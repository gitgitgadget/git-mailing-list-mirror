From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Tue, 23 Mar 2010 11:43:09 -0700
Message-ID: <20100323184309.GA31668@spearce.org>
References: <20100323161713.3183.57927.stgit@fredrik-laptop> <20100323173114.GB4218@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 19:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu94R-0004Rp-OC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 19:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab0CWSnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 14:43:14 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:38030 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab0CWSnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 14:43:13 -0400
Received: by pzk32 with SMTP id 32so503698pzk.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 11:43:13 -0700 (PDT)
Received: by 10.142.209.1 with SMTP id h1mr1792699wfg.44.1269369792682;
        Tue, 23 Mar 2010 11:43:12 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm5228520iwn.15.2010.03.23.11.43.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 11:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100323173114.GB4218@fredrik-laptop>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143041>

Fredrik Kuivinen <frekui@gmail.com> wrote:
> +static int multiple_threads;
> +#ifndef NO_PTHREADS
> +int xpthread_create(pthread_t *thread, const pthread_attr_t *attr,
> +		    void *(*start_routine)(void*), void *arg)
> +{
> +	multiple_threads = 1;
> +	return pthread_create(thread, attr, start_routine, arg);
> +}
> +#endif
> +
>  void *xmalloc(size_t size)
>  {
>  	void *ret = malloc(size);
>  	if (!ret && !size)
>  		ret = malloc(1);
> -	if (!ret) {
> +	if (!ret && !multiple_threads) {
>  		release_pack_memory(size, -1);

So by "make thread safe" you really mean "disable release of
least-frequently used pack windows once any thread starts".

If that is what we are doing, disabling the release of pack windows
when malloc fails, why can't we do that all of the time?

-- 
Shawn.
