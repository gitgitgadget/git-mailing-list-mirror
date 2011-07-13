From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to
 remove D/F entries
Date: Wed, 13 Jul 2011 09:17:57 +0200
Message-ID: <4E1D46A5.6050904@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-27-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 09:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtiC-0001fN-Vb
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016Ab1GMHSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:18:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8458 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996Ab1GMHSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:18:08 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Qgthm-0000fA-Cl; Wed, 13 Jul 2011 09:18:05 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 159561660F;
	Wed, 13 Jul 2011 09:17:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1307518278-23814-27-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177006>

Am 6/8/2011 9:30, schrieb Elijah Newren:
> +static int make_room_for_path(const struct merge_options *o, const char *path)
>  {
> -	int status;
> +	int status, i;
>  	const char *msg = "failed to create path '%s'%s";
>  
> +	/* Unlink any D/F conflict files that are in the way */
> +	for (i = 0; i < o->df_conflict_file_set.nr; i++) {
> +		const char *df_path = o->df_conflict_file_set.items[i].string;
> +		size_t pathlen = strlen(path);
> +		size_t df_pathlen = strlen(df_path);
> +		if (df_pathlen < pathlen && strncmp(path, df_path, df_pathlen) == 0) {
> +			unlink(df_path);
> +			break;
> +		}
> +	}

Each time this loop is entered it tries to remove the same path again,
even if it does not exist anymore or was morphed into a directory in the
meantime. I suggest to remove a path from o->df_conflict_file_set after it
was unlinked. Or even better: have a separate "make room" phase somewhere
in the merge process.

-- Hannes
