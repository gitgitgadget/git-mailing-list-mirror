From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] wt-status: fix possible use of uninitialized variable
Date: Thu, 21 Mar 2013 12:49:50 -0700
Message-ID: <20130321194949.GG29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321110527.GA18819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlVr-0006X6-CW
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab3CUTuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:50:03 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:55263 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab3CUTty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:49:54 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so2493852pbc.25
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LKTNhm2D9Dap6hXBHEpsCoMHiidH1roIXxoX6yc0FEc=;
        b=TwAGNiQ25e7RjzyerSePPeEqZd9OT8jcGBOzn27RlSmoh8AVxwxxrKwreex2owJQJg
         NUNR0vWy7Hv5FrMvuXG4XseGYRvFXkPRY84bEBd0qeGwjldFnj2NVgHkEuk1G4CyBKDN
         MpBS0jH5CoLW/zpESHH/IvP9ecsWuKTjPabINkV4psbuf6Z+EE5du9xG0g6QvN3Ah4C1
         mmUwil7R/c9HweU8YoQQaLprZpjGgKvbSj7GTlxxwqP3Tspgi2QkjJMzJs8m8DuKs2X5
         HDcJdyIwWSApv9kO9AC0MSFgqHCgPDH6FPuO1JoSx2XaMWsmEHIT14QGnXNGylzeGJkq
         LlqA==
X-Received: by 10.68.180.162 with SMTP id dp2mr7591384pbc.214.1363895394498;
        Thu, 21 Mar 2013 12:49:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rr14sm7126719pbb.34.2013.03.21.12.49.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 12:49:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130321110527.GA18819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218748>

Jeff King wrote:

> Instead of using the "x = x" hack, let's handle the default
> case in the switch() statement with a die("BUG"). That tells
> the compiler and any readers of the code exactly what the
> function's input assumptions are.

Sounds reasonable.

> We could also convert the flag to an enum, which would
> provide a compile-time check on the function input.

Unfortunately C permits out-of-bounds values for enums.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -264,7 +264,7 @@ static void wt_status_print_change_data(struct wt_status *s,
>  {
>  	struct wt_status_change_data *d = it->util;
>  	const char *c = color(change_type, s);
> -	int status = status;
> +	int status;
>  	char *one_name;
>  	char *two_name;
>  	const char *one, *two;
> @@ -292,6 +292,9 @@ static void wt_status_print_change_data(struct wt_status *s,
>  		}
>  		status = d->worktree_status;
>  		break;
> +	default:
> +		die("BUG: unhandled change_type %d in wt_status_print_change_data",
> +		    change_type);

Micronit: s/unhandled/invalid/.

Thanks,
Jonathan
