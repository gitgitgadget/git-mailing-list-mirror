From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 08/35] lock_file(): always add lock_file object to
 lock_file_list
Date: Thu, 18 Sep 2014 06:32:07 +0200
Message-ID: <541A6047.6000707@web.de>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 18 06:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUTOh-0002NL-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 06:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbaIREcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 00:32:36 -0400
Received: from mout.web.de ([212.227.17.12]:51654 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbaIREcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 00:32:35 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LmcnP-1Y3XMF1vAx-00aFQ4; Thu, 18 Sep 2014 06:32:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:SCUL7LRGMJ9wc3fzXO/euhIqhx3sIFxDdVskIYRi+eSeKwLzwnA
 eYHr56PbxBSwZp+u5jItbkznyctsA6ZiQ7zodBEvjFU/P9a8EJcWXqtNbJrGTfuf/AJaRmb
 YRrgbdOvpEAjxpGcxu+SwZtPIS/QTiYesDwvtj3UoJZY8lu9JwkOOFHEYiP7kjyPokObMcg
 aL6qhvShKeKFgDG2FN64g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257253>

On 09/16/2014 09:33 PM, Michael Haggerty wrote:
[]
>
> diff --git a/lockfile.c b/lockfile.c
> index 983c3ec..00c972c 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -129,6 +129,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	 */
>  	static const size_t max_path_len = sizeof(lk->filename) - 5;
>  
> +	if (!lock_file_list) {
> +		/* One-time initialization */
> +		sigchain_push_common(remove_lock_file_on_signal);
> +		atexit(remove_lock_file);
> +	}
> +
> +	if (!lk->on_list) {
> +		/* Initialize *lk and add it to lock_file_list: */
> +		lk->fd = -1;
> +		lk->owner = 0;
> +		lk->on_list = 1;
> +		lk->filename[0] = 0;
Does it makes sense to change the order here:

Do the full initialization, and once that is completed, set on_list = 1
+		lk->filename[0] = 0;
+		lk->on_list = 1;
