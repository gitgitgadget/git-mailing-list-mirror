From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 4/8] Add a function to set a non-default work tree
Date: Sat, 19 Apr 2008 22:07:08 -0700
Message-ID: <7vprslcdxf.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0804171931550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 07:08:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnRmr-0003F0-Ji
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 07:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbYDTFH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 01:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbYDTFH1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 01:07:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYDTFH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 01:07:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A145559D8;
	Sun, 20 Apr 2008 01:07:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CAA0F59D3; Sun, 20 Apr 2008 01:07:20 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0804171931550.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 17 Apr 2008 19:32:33 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79951>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  cache.h       |    1 +
>  environment.c |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 96dcb49..d88a4e2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -311,6 +311,7 @@ extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
>  extern const char *get_git_work_tree(void);
> +extern void set_git_work_tree(const char *tree);
>  
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
> diff --git a/environment.c b/environment.c
> index 6739a3f..d6c6a6b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -81,6 +81,12 @@ const char *get_git_dir(void)
>  	return git_dir;
>  }
>  
> +void set_git_work_tree(const char *new_work_tree)
> +{
> +	get_git_work_tree(); /* make sure it's initialized */
> +	work_tree = xstrdup(make_absolute_path(new_work_tree));
> +}
> +

Somehow this feels wrong.  Maybe you would need to move that "static int"
variable inside get_git_work_tree() outside so that you can reset from
this new function at will?

How should the setting of new work tree from sideways using this interface
interact with bareness of the repository?

Should it reset is_bare_repository_cfg to zero?  Should it refuse to set a
work tree if is_bare_repository_cfg is true already?
