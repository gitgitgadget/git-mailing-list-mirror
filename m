From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] run-command: factor out running_main_thread function
Date: Mon, 15 Apr 2013 18:45:04 -0700
Message-ID: <20130416014504.GD3262@elie.Belkin>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230816.GB11267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 03:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URuxQ-00069v-GR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 03:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879Ab3DPBpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 21:45:10 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:47576 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934863Ab3DPBpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 21:45:09 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so2319405dak.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 18:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MJ7bebD0AXqDOfUHtrYIkeJmrXAZxpJZsK6HrX2Ip9U=;
        b=tDM477vYFys5htmnO+XNHcab3PQs2R58TubyUh7P36ZaIJfgCuPaURT3tvjQdHzkfA
         RkKacZ7vT9iBtzRn3LCKRibwgr8rOTgzBgFsI3Xgae7i4enfeWphdoc99cvw4VShzKM4
         sWq1GPRiTOI0OzZlQCU041CP9l80wgGo6bOcHLjfRwDq5IHOzfCLrIBoKeZkaRkUoZmm
         7birNNeIO+Umatm1yNH2tQm2sMMPylIiOHUUe6t2QDajnq5pSKQo4yGmLNIU+4SeFpEi
         5sVpFT1r8d25BAIau8U+6g1oGOrgW6YemTFboyrbhSP6dKEI9G4ZdEZni43E9bOxesCl
         08+w==
X-Received: by 10.66.144.69 with SMTP id sk5mr869692pab.69.1366076708881;
        Mon, 15 Apr 2013 18:45:08 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id pa2sm353594pac.9.2013.04.15.18.45.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 18:45:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130415230816.GB11267@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221343>

Jeff King wrote:

> --- a/run-command.c
> +++ b/run-command.c
> @@ -603,7 +603,7 @@ static NORETURN void die_async(const char *err, va_list params)
>  {
>  	vreportf("fatal: ", err, params);
>  
> -	if (!pthread_equal(main_thread, pthread_self())) {
> +	if (!running_main_thread()) {
>  		struct async *async = pthread_getspecific(async_key);
>  		if (async->proc_in >= 0)
>  			close(async->proc_in);
> @@ -614,6 +614,19 @@ static NORETURN void die_async(const char *err, va_list params)
>  
>  	exit(128);
>  }
> +
> +int running_main_thread(void)
> +{
> +	return pthread_equal(main_thread, pthread_self());
> +}

Would it make sense to do something like

	return !main_thread_set || pthread_equal(...);

in case someone tries to call this before the first start_async call?
