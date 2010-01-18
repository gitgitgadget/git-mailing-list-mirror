From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Threaded grep
Date: Mon, 18 Jan 2010 12:11:19 +0100
Message-ID: <4B5441D7.40503@viscovery.net>
References: <20100118103334.GA17361@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 12:12:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWpX0-0001HS-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 12:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab0ARLL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 06:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142Ab0ARLL1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 06:11:27 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11752 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0ARLL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 06:11:27 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NWpVv-0001Iz-Rr; Mon, 18 Jan 2010 12:11:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8CD841660F;
	Mon, 18 Jan 2010 12:11:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100118103334.GA17361@fredrik-laptop>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137383>

Fredrik Kuivinen schrieb:
> The patch has been rebased on top of next and I believe that it is now
> ready for inclusion. It is time to decide if the added code complexity
> is worth the increased performance.

I also have to add a few nits to make this play better on Windows.

> +/* This lock protects all the variables above. */
> +static pthread_mutex_t grep_lock = PTHREAD_MUTEX_INITIALIZER;
> +
> +/* Signalled when a new work_item is added to todo. */
> +static pthread_cond_t cond_add = PTHREAD_COND_INITIALIZER;
> +
> +/* Signalled when the result from one work_item is written to
> +   stdout. */
> +static pthread_cond_t cond_write = PTHREAD_COND_INITIALIZER;
> +
> +/* Signalled when we are finished with everything. */
> +static pthread_cond_t cond_result = PTHREAD_COND_INITIALIZER;

Please do not use PTHREAD_MUTEX_INITIALIZER nor PTHREAD_COND_INITIALIZER;
call pthread_mutex_init and pthread_cond_init (and the corresponding
*_destroy!!) from the code.

> +static void add_work(enum work_type type, char *name, char *buf, size_t size)
> +{
> +...
> +	pthread_mutex_unlock(&grep_lock);
> +	pthread_cond_signal(&cond_add);

Please swap these two lines, so that pthread_cond_signal() is called while
the lock is held.

> +	/* Wake up all the consumer threads so they can see that there
> +	   is no more work to do. */
> +	pthread_cond_broadcast(&cond_add);
> +	pthread_mutex_unlock(&grep_lock);

Ouch! We do not have pthread_cond_broadcast() on Windows, yet. This
shouldn't be a stopper for this patch, though. Perhaps Andrzej (cc:ed) can
implement it?

-- Hannes
