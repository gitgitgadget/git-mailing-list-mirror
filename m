From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Sat, 20 Mar 2010 07:35:20 -0500
Message-ID: <20100320123520.GA29041@progeny.tock>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
 <1269051518-25099-2-git-send-email-bmeyer@rim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benjamin C Meyer <bmeyer@rim.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 13:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsxsw-0007Xu-TP
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 13:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab0CTMea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 08:34:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50184 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0CTMe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 08:34:29 -0400
Received: by gyg8 with SMTP id 8so1928389gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OIwR9ZjYATLJpMCgC2+yG34digNVmsbNvLs+iBDNlCY=;
        b=BOXHEVoP0DoZg4Jb8AtvkZVTxB7pqw1HwwtSdsRN5CQDTJHopT3HPOhfC2V4j7o2Aa
         D+0eAFSY8cPZvcAIoNDIns4cbiRyHJljMP9pqXrgmTiSqdpSTXiqUK9zJfjYVaXV/evM
         W5yIxSrWkiHxY4FrH9JtrDFKcf6S7hUZ9FdKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tjwFIoAj008HQ+IBc/V4mEuN8FMQQdP8vD731vKSdx2suy10rN6c1NZViBuWvLvJpF
         oSgxeFFb2s2QPzi8dPef6kB00TU3mpR0bxz/pgDXAV+m+jVMUO/V4dl0WktT4XxASJqQ
         Sc+4d9s7hcyPApXjJg4PuOMDn3CRYJIo3SJHI=
Received: by 10.90.183.7 with SMTP id g7mr1769033agf.42.1269088468320;
        Sat, 20 Mar 2010 05:34:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1269926iwn.15.2010.03.20.05.34.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 05:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269051518-25099-2-git-send-email-bmeyer@rim.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142705>

Benjamin C Meyer wrote:

> -	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
> +	for reflog in $(git rev-list --quiet -g $remoteref)

Are you sure?  My local copy of git-rev-list.1 says

    --quiet
         Don=E2=80=99t print anything to standard output. This form is =
primarily meant
         to allow the caller to test the exit status to see if a range =
of
         objects is fully connected (or not). It is faster than redirec=
ting
         stdout to /dev/null as the output does not have to be formatte=
d.

A similar question applies to the other patches in this series: are
you sure they suppress the right output?  (I haven=E2=80=99t checked, j=
ust
asking.)

Aside: that for loop looks like it could be improved.  Maybe it is wort=
h
factoring this into a separate function, something like:

old_upstream() {
	remoteref=3D$1 &&
	curr_branch=3D$2 &&

	oldremoteref=3D"$(git rev-parse -q --verify "$remoteref")" &&
	{ git rev-list -g "$remoteref" 2>/dev/null || return $?; } |
	while read reflog
	do
		if test -z "$(git rev-list "$curr_branch".."$reflog" | head -n 1)"
		then
			printf "%s\n" "$reflog"
			return 0
		fi
	done &&
	printf "%s\n" "$oldremoteref"
}

In other words, we can avoid walking the whole reflog before starting
to look for an ancestor for the current branch.

Jonathan
