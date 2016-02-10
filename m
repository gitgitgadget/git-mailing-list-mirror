From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv9 4/6] git submodule update: have a dedicated helper for cloning
Date: Tue, 9 Feb 2016 18:26:47 -0800
Message-ID: <CA+P7+xo=GK79DRvV6ZYds3wx6bayoWHC49UmkWL20=xo=jpS2g@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com> <1455051274-15256-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 03:27:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTKUr-0003Pc-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 03:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbcBJC1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 21:27:09 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35741 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbcBJC1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 21:27:07 -0500
Received: by mail-ig0-f170.google.com with SMTP id hb3so5200427igb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g071aWo2WI6cM2fgrOU/9sDJ0kqJUh6TcLKafgYPtVI=;
        b=r1WZWg3uSIuMQUOROf4nGCjdyIsG6gdhivq+7C2gA9Q2XUorN3Iz9LEKRnphLBmNrA
         XywwmF+cbA5ZKkVDKRrxSJraCcjk37eAJf4s22pgo43zcDH0xPxBl7DkqRaiNNX/JCUk
         T7Dr7msUVpYQ3Ntg5YB6f3DWlpQ+fmi7yfajReiDu7YDgPAggYxNYzlIgS3qRZFRASmK
         jC0z3aBlp/oqOTJDdCsWTenU/9Wp4j2z46QVbw+0C4enuYIFTGuRCHelkaLpkkMyFWFA
         npo8TqzXReBJ42CXtEo1/+aJhmyNqFgE2gYB9qR+R8ioRHX9E/UD7Dak9rvaEKezGC3w
         741Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=g071aWo2WI6cM2fgrOU/9sDJ0kqJUh6TcLKafgYPtVI=;
        b=VfRGdiRYRcmyKtfrnCDhLECLm0iwLcvceAL0rbB4aXKEzHSiy7NZQvXiyRBGuQISYk
         rTwcxf0XG58WyxG4O02+8dkcti3dOuxJEMVEZ177iHuyxDay/L4Lg5bcUSwzCsgY/OPN
         WT6otOyAtZi0Shjai1KeOFtQ1PyWqR4LzyQDtGLNlKZA+I49n+0olGkZK3kvAfsAsps8
         Dxc/dL0/jTW6NP30Qt2ZYkPaQ9uCFSbbdAePm0IYju9WhKyfhYHXdTkDCp5MuyshxIgk
         NP9qNfSoIADbdB6Mb8Gs4sBncLzrjv7jV/b90WO2EkDNfGMnJB0jeYVzH9D6mWBwGypF
         s5iA==
X-Gm-Message-State: AG10YOS1oW6GsCY8dQVAdDW+jyraIRoNCXg2ZiXYRCnSHXmEyz6GwO13/y0iH816h0s6hNfHmrHjOy+upkY00g==
X-Received: by 10.50.72.48 with SMTP id a16mr7114815igv.73.1455071226510; Tue,
 09 Feb 2016 18:27:06 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Tue, 9 Feb 2016 18:26:47 -0800 (PST)
In-Reply-To: <1455051274-15256-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285890>

On Tue, Feb 9, 2016 at 12:54 PM, Stefan Beller <sbeller@google.com> wrote:
> This introduces a new helper function in git submodule--helper
> which takes care of cloning all submodules, which we want to
> parallelize eventually.
>
> Some tests (such as empty URL, update_mode=none) are required in the
> helper to make the decision for cloning. These checks have been
> moved into the C function as well (no need to repeat them in the
> shell script).
>
> As we can only access the stderr channel from within the parallel
> processing engine, we need to reroute the error message for
> specified but initialized submodules to stderr. As it is an error
> message, this should have gone to stderr in the first place, so it
> is a bug fix along the way.
>

I was recently working on a way to make submodule pass some parameters
from the parent project into the submodule project (specifically
settings regarding authentication such as using an authentication
helper), and I think this would make it easier to do.

Thanks,
Jake
