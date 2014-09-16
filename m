From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 11/35] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Tue, 16 Sep 2014 14:11:40 -0700
Message-ID: <20140916211140.GL29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:11:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU02N-0007Nr-JD
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbaIPVLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 17:11:44 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64455 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbaIPVLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 17:11:43 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so588777pab.33
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UfvPXb7e4uGH5ilFOwcs2fs0y4VQSsNbas2DqtMgqus=;
        b=eiUQk7bSdB1StiSCAGkwzF2QeoUry5mS3fszoPKbbTy8maZhc/ZNd8gRaB3SCsa2cI
         ou/a/pBEo/YZCJOhKfqLAHjG8obXXzvHMNH4z1fmF5S510l1gy/5M+whgrqIWM/eHxMa
         25B7MpVcRoJpaQUJ4TBmbD+YRXHzNofCp21BPjTdQZawMcihKILcXo8zwuZQMS96+iU7
         yo9Dg6KAYfznPR5EqRGjIJHavLHT/50EADt0U5JWh1fXRD237Pl+psBPI/y67GKjRcul
         Gel3lcjJYI4cdwssTHe3mjAmbNt2MfFAPGjJNUghzvRELRbQGsjuCcYhrcJ/GdWSp0PB
         g2bQ==
X-Received: by 10.66.217.166 with SMTP id oz6mr52718037pac.23.1410901902864;
        Tue, 16 Sep 2014 14:11:42 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id na4sm14903750pdb.96.2014.09.16.14.11.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 14:11:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-12-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257195>

Michael Haggerty wrote:

> It's bad manners. Especially since there could be a signal during the
> call to unlink_or_warn(), in which case the signal handler will see
> the wrong filename and delete the reference file, leaving the lockfile
> behind.
>
> So make our own copy to work with.

Nice.  Could this be a helper, to help others avoid a PATH_MAX
sized buffer too?

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -2551,12 +2551,15 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  static int delete_ref_loose(struct ref_lock *lock, int flag)
[...]
> +		/*
> +		 * loose.  The loose file name is the same as the
> +		 * lockfile name, minus ".lock":
> +		 */
> +		char *loose_filename = xmemdupz(
> +				lock->lk->filename,
> +				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);

Ronnie mentioned that this would misbehave in the
!lock->lk->filename[0] case, which shouldn't come up because
lock_ref_sha1_basic dies on error but seems worth futureproofing
against.  Maybe something like

	assert(lock->lk->filename[0]);

would be enough to make the assumption obvious for people reading.

Otherwise looks good.

Thanks,
Jonathan
