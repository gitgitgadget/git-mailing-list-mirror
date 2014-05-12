From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Mon, 12 May 2014 11:44:26 -0700
Message-ID: <20140512184426.GO9218@google.com>
References: <20140505212938.GA16715@sigill.intra.peff.net>
 <20140506151441.GA25768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 12 20:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvDG-0001fR-AY
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaELSoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 14:44:30 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43207 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaELSo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:44:29 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so9159202pab.7
        for <git@vger.kernel.org>; Mon, 12 May 2014 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KkNmcRlViZ6a7m7y9S87fjOzREpc7Y9zsQFitzMVfeU=;
        b=FhcM3XAT0AZzFdpc454TYJPv09GdHvh03EPxP4xMOVew8WGB9WJUCb1t4Wb/hh/wzr
         TyQD3NVK8jKAGVz3+pMxC0VBL0ZM+nq0Uq8R5r+8OhjkXcpula9D9V6/IEUfHlqPeMA1
         0wGM8TsHdV/wFq0qEaUMiG2i/tw+o9fP915OZ5DTX5qJzbefhENa3fDp5ayYSBIAlcnm
         2yOUqLr84SgOTiWbhEP46Zf5bn92OfiBVOc/KtgDMADAvf+GC86Jo9OMIQ8D2eOY9A61
         dvAaNCFcva0d0/zcKR0S6gbGnl+zwx3AuWjWSYLRr/oT8SrvDw4fCBpQ9zbsOY8BJYZK
         Q96A==
X-Received: by 10.66.141.144 with SMTP id ro16mr57502463pab.131.1399920269132;
        Mon, 12 May 2014 11:44:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oe4sm24114072pbb.33.2014.05.12.11.44.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 May 2014 11:44:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140506151441.GA25768@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248718>

Hi,

Jeff King wrote:
> On Mon, May 05, 2014 at 05:29:38PM -0400, Jeff King wrote:

>> I cannot think of any other way to make the compiler aware of the
>> constant value, but perhaps somebody else is more clever than I am.
>
> This came to me in a dream, and seems to work.

Clever. :)  Thanks for thinking it up.

[...]
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -331,7 +331,11 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
>   * using the function as usual.
>   */
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define error(...) (error(__VA_ARGS__), -1)
> +static inline int const_error(void)
> +{
> +	return -1;
> +}
> +#define error(...) (error(__VA_ARGS__), const_error())

I wish we could just make error() an inline function that calls some
print_error() helper, but I don't believe all compilers used to build
git are smart enough to inline uses of varargs.  So this looks like
the right thing to do.

I kind of wish we weren't in so much of an arms race with static
analyzers.  Is there some standard way to submit our code as "an idiom
that should continue not to produce warnings" to be included in a
testsuite and prevent problems in the future?

Thanks,
Jonathan
