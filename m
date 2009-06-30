From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by
 default in git-clean
Date: Tue, 30 Jun 2009 08:07:01 +0200
Message-ID: <4A49AB85.40303@gnu.org>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com> <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com> <1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 08:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLWUt-000237-Uu
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 08:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbZF3GHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 02:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZF3GHF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 02:07:05 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:37257 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbZF3GHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 02:07:03 -0400
Received: by bwz9 with SMTP id 9so3673337bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pZE6y97aCMEwdznmdt9FQJds2gC6lJGtONd2JgAP49k=;
        b=PcRRZA4BwYgJmt1U/UqS6w0c7PxfMqPv6+IgGqMzRepic5FA5YUs0FkmrhjiXwdk33
         7ebihjGnJlfFDsv3LMgL0KBUKlcjJO23vuti8giF2LqfFhgNf6n0764FR66pTXsVxJQW
         8L6I1YRbWP1AlNA21xIADwXB/AgykguEZscfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kC9zSIehpyjmWgHj3GWIZPiGiF8e33uVxV5TmJjMrG6Yz0eF0r51D8Kbjmugt3RBY0
         u2P7KWatfAeEww3YIseEJAVUkX4PuxNbzSbam+qU/pgjd0jFwgZtB/3JV3yHscjOxYze
         hP1yTIfaMC62wWpSH25T2xj3OojGy+gsyLmzk=
Received: by 10.204.122.141 with SMTP id l13mr7978748bkr.106.1246342024198;
        Mon, 29 Jun 2009 23:07:04 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id z15sm8174661fkz.4.2009.06.29.23.07.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 23:07:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
In-Reply-To: <1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122490>

Useful indeed.

Note that 'git clean -n -d ' however will still report the directory as 
being removed.  Also, I'm not sure what happens (and what should happen) 
if an untracked directory foo.git is found.

Probably the best way to fix this is to add an is_dot_git_path function 
to dir.c like this

int
is_dot_git_path (const char *s, int len);
{
   while (len && s[len - 1] == '/')
     len--;
   return len >= 4 && !memcmp (s + len - 4, ".git", 5) &&
          (len == 4 || s[len - 5] == '/');
}

This function is safer if the directory does not have a trailing slash, 
as it might be for the paths in builtin-clean.c for the -n case.  You 
can have some adjustments if you decide do keep foo.git (just removing 
the last && of course).

Thanks!

Paolo
