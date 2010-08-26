From: Jonathan Nieder <jrnieder@gmail.com>
Subject: setting working dir in posix_spawn() (Re: Fix 'git log' early
 pager startup error case)
Date: Thu, 26 Aug 2010 01:18:15 -0500
Message-ID: <20100826061815.GH9708@burratino>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
 <20100825013625.GC10423@burratino>
 <4C74BFA7.1090907@viscovery.net>
 <4C752739.3010808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>,
	austin-group-futures-l@opengroup.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 08:20:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVog-0001tJ-6J
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab0HZGT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:19:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52393 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0HZGT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:19:56 -0400
Received: by iwn5 with SMTP id 5so1298236iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9J8qByNW6y74CuWzEwJndjQaq6Pu8kwxpp7TntO60y0=;
        b=Z2Aa47VmHWQKpziRDr4zmUOs61boISxhRvPlVQ2p+LIIvbZknVbekZgcO+iMR2pJHy
         1ta/mSLbsT/q6QFmW2tWH2+6fQNi0gGuRvexDB7fv1izWeWjYL1Egi/l/85YENPDaek7
         HdJDCNgDvUTjfsnOEKiCkim+46nlGmE5/6sIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z9nyIxPhygkj4SCAi0fSLKRlhRK8mfN1iqB84NSgs16vJerA94xKRopEaFMe2ewetH
         pR1PAPx0U5AraM9mNM22pIiC78Cq4KE5IKipaFL8/TZaHQ7zvBfpws1bueEXM/TWEFpo
         FVfPasebouZKTOj65FiYv5dTN14M47UUMnhgo=
Received: by 10.231.35.202 with SMTP id q10mr11340089ibd.138.1282803595867;
        Wed, 25 Aug 2010 23:19:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2172503ibb.8.2010.08.25.23.19.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:19:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C752739.3010808@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154516>

(+cc: austin-group-futures)

Eric Blake wrote:
> On 08/25/2010 01:00 AM, Johannes Sixt wrote:

>> Just FYI, posix_spawn() is not sufficiently capable for the demands of
>> start_command(): It doesn't allow to set a new CWD for the spawned process.
>
> And even if posix_spawn() were capable, cygwin doesn't yet implement it.

Hmm, okay.  You have access to win32api, though, right?  So it should
be possible to reuse code from compat/mingw.c::mingw_spawnvpe.

Do you think there would be any interest in a posix_spawn() variant
that takes a dir parameter?  I am imagining something like this:

 int posix_spawn2(pid_t *restrict pid, const char *restrict path,
	const posix_spawn_file_actions_t *file_actions,
	const posix_spawnattr_t *restrict attrp,
	char *const argv[restrict], char *const envp[restrict],
	const char *dir);

or this:

 int posix_spawn2(pid_t *restrict pid, const char *restrict path,
	const posix_spawn_file_actions_t *file_actions,
	const posix_spawnattr_t *restrict attrp,
	char *const argv[restrict], char *const envp[restrict],
	int dirfd);

or this:

 int posix_spawn_file_actions_addchdir(posix_spawn_file_actions_t
	*file_actions, int dirfd);
