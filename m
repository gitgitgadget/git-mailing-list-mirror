From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 01:56:52 +0200
Message-ID: <487BE7C4.2050207@gmail.com>
References: <4876B223.4070707@gmail.com> <200807142323.22761.jnareb@gmail.com> <487BDB34.7010002@gmail.com> <200807150114.44402.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXva-0005VI-CB
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950AbYGNX46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759951AbYGNX46
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:56:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:47664 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759948AbYGNX45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:56:57 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3028687fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=dATxajrayiS28OLoZJ94nlOMc5ecYovVEzf2Dgh96Uw=;
        b=ptOjr2vSEGGW2RyGMWDmpCeExJQvhG0mbjuEfHdG/nIoK91rwd6NAPeM9IjlnlUb7v
         tdE296NO9ZdHBybw/TTIbiPja38gweWUdl3PnZeRBMClbQW/H2HnApkD3GRz/T7yt47n
         RSS6drEWntm35ofSRE5HcTQVumDZ4e54MGwU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=KYL8+HryXp9bIsS20iJyFOBoMNNcDD03rQ0DdcX6DlHvr7S7G/uIQgdt5vYHGkD1FS
         tSAcXvvBcVBq14ALulmIXsfcDQaf+K7IkBxFz8ALhLa70B5bgv3JWL7zNKTklAMZ1ikt
         urs9DvmMzGIigyYjoThj8QXR+gj1X0yFbE0YU=
Received: by 10.187.223.6 with SMTP id a6mr2063625far.45.1216079815528;
        Mon, 14 Jul 2008 16:56:55 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id 12sm12854025fks.9.2008.07.14.16.56.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:56:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807150114.44402.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88484>

Jakub Narebski wrote:
> Lea Wiemann wrote:
>> Gitweb's cache is actually never out-of-date
> 
> Could you explain then how gitweb cache is invalidated?

Sure; from gitweb.perl:

# Transient cache entries (like get_sha1('HEAD')) are automatically
# invalidated when an mtime of either the repository's root directory
# or of the refs directory or any subdirectory changes.  This
# mechanism *should* detect changes to the repository reliably if you
# only use git or rsync to write to it,

IOW, gitweb will do a small number of (inexpensive) stat calls on those
directories each time it's called, and use the most recent mtime as part
of the cache key for transient entries.  Hence those transient entries
will automatically become invalid once the most recent mtime changes.

(If any of the relevant directories has been modified since the last
time gitweb checked, gitweb will re-scan the whole tree to check for new
directories, and record their mtimes as well.  See get_last_modification
if you're interested in more gory details.)

The punchline is, the cache never returns outdated data.
