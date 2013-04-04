From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] t9700: do not close STDERR
Date: Thu, 4 Apr 2013 14:11:15 -0700
Message-ID: <20130404211114.GQ30308@google.com>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <3689abc8e1af4ddbbb7791dd6241996f86e4efa2.1365107899.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>, Petr Baudis <pasky@ucw.cz>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrRn-0006Ti-7P
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763355Ab3DDVLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:11:21 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33131 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763232Ab3DDVLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:11:19 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1649705pdc.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3n7hbZpqdbHnwEOHDpF//xUyW2d9MmK2HAYBeq0K8Xo=;
        b=AD0cgHYdgNyKInaETh3H7vTlzVYlHFt6ixdzFhyHdlHpG8OJdrUW5soSHtgjCc+rOY
         LOiTi/1BWWupusqk2i+uWhdyBq/XkbpOuA8AvNvc1rN1Gnr68IUf2bE/PzNUV+Fqq5i3
         CjB5DWcFrCXMBQIl5k0qAvWQLIKkU6dS5Dxhtl65UvZL3Yb24nO4pFsIuStzvlwwLG3S
         N7j3pAQhQdhxn7HteeFBdNh6zjrz8AweLH+XIa6n+vn7sR2oFVAjsou6ALZSRuZjBrgq
         /Kqeev3dLHnw7TySpwprlXfQHTolncvBsJ2/i5Eqdys+7Ra+aULBxxOew6Qo11jegEkn
         g4+A==
X-Received: by 10.66.49.229 with SMTP id x5mr11788924pan.185.1365109878839;
        Thu, 04 Apr 2013 14:11:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ux10sm12904082pab.1.2013.04.04.14.11.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 14:11:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3689abc8e1af4ddbbb7791dd6241996f86e4efa2.1365107899.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220106>

Thomas Rast wrote:

> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -45,7 +45,8 @@ is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
>  # Failure cases for config:
>  # Save and restore STDERR; we will probably extract this into a
>  # "dies_ok" method and possibly move the STDERR handling to Git.pm.
> -open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
> +open our $tmpstderr, ">&STDERR" or die "cannot save STDERR";
> +open STDERR, ">", "/dev/null" or die "cannot redirect STDERR to /dev/null";
>  is($r->config("test.dupstring"), "value2", "config: multivar");
>  eval { $r->config_bool("test.boolother") };
>  ok($@, "config_bool: non-boolean values fail");
>  open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";

Yeah, this makes sense.

At first I was confused: why not just let stderr go out to the console,
where a person reading can see it?  But this test is meant to be run
using test_external_without_stderr, which redirects stderr to a file and
dies if it ends up getting any content.

perlfunc(1) documents the close-and-then-open trick for redirecting a
filehandle to an in-memory buffer.  Here a plain reopen works fine.

So for what it's worth
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
