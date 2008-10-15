From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Preserve file permissions on git-reflog expire
Date: Wed, 15 Oct 2008 10:54:15 -0700
Message-ID: <7v3aix4ud4.fsf@gitster.siamese.dyndns.org>
References: <48F629C2.70203@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqAat-0004F6-NU
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYJORyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 13:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbYJORyX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 13:54:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbYJORyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 13:54:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01A9D6F029;
	Wed, 15 Oct 2008 13:54:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D51D56F026; Wed, 15 Oct 2008 13:54:17 -0400 (EDT)
In-Reply-To: <48F629C2.70203@datacom.ind.br> (Samuel Lucas Vaz de Mello's
 message of "Wed, 15 Oct 2008 14:34:58 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C091DAE-9AE2-11DD-8302-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98292>

Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br> writes:

> Preserve file permissions on git-reflog expire to avoid problems with shared repositories and git-gc.

Looong line needs wrapped (I could do this myself if this was the only
issue, but...)

> Signed-off-by: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
>
> ---
>
> This small patch fixes a bug with shared repositories and git-reflog expire.

> samuel@erdinger:~/myrepo$ git push 
> Counting objects: 5, done.
> Compressing objects: 100% (3/3), done.
> Unpacking objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 295 bytes, done.
> Total 3 (delta 2), reused 0 (delta 0)
> error: Unable to append to logs/refs/heads/master: Permission denied 
> To /remote/myrepo/
> ! [remote rejected] master -> master (failed to write)
> error: failed to push some refs to '/remote/myrepo/' 

Thanks for a reproduction recipe.  I think an abbreviated version of this
would deserve to be in the commit log message proper.

> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index 6b3667e..92a0d53 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -265,6 +265,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>  	struct cmd_reflog_expire_cb *cmd = cb_data;
>  	struct expire_reflog_cb cb;
>  	struct ref_lock *lock;
> +	struct stat filestat;
>  	char *log_file, *newlog_path = NULL;
>  	int status = 0;
>  
> @@ -303,6 +304,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>  			status |= error("Couldn't write %s",
>  				lock->lk->filename);
>  			unlink(newlog_path);
> +		} else if (stat(log_file, &filestat)){
> +			status |= error("unable to read permissions of %s", log_file);

Hmmm.  Is there a reason you did not use adjust_shared_perm() like all the
other codepaths for creating files under .git/ directory do?
