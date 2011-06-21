From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/13] revert: Introduce struct to keep command-line
 options
Date: Tue, 21 Jun 2011 11:58:54 -0500
Message-ID: <20110621165854.GL15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:59:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4I8-0006NS-1d
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab1FUQ7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 12:59:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63695 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1FUQ7B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:59:01 -0400
Received: by iwn6 with SMTP id 6so2223651iwn.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rtsCBWciqwJO67NNufvho5cdtwyH9TpYPMTZlf6I/bU=;
        b=sVOtTAEOCkv/wQlRwEjcMUflONqC4yihg0dnPBgkdAXTt9lFgeNHdydIkGa8pvf/D6
         0AIHJuCz/4DBgN3NQ+pI6Z2MHELn4SHaiuz4x2+k4+gprGJzkpMQXY+NUyGsNuAhMErr
         VSJl/NSS9eEMmTIPhimkr2HmY5ondu8E2X5b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M8xHhlCS9HmtCk73y3QDdg3HFgbBL+YN9NqjhUEN6LvFjpegADXATEoXTQVGONKnZ8
         M38EVhP8UdjPC73WTQgWCXJ76BXbt2EK9hfHTaADLobv1SEm5id1cssi29Kp2KoAkg1m
         8YvK/C9CV8rBIhpX4L12E7WyeYZ8RT6OS2A6Y=
Received: by 10.42.140.4 with SMTP id i4mr7556897icu.130.1308675540567;
        Tue, 21 Jun 2011 09:59:00 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id vn4sm6932511icb.7.2011.06.21.09.58.57
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 09:58:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176171>

Ramkumar Ramachandra wrote:

> The current code uses a set of file-scope static variables to tell the
> cherry-pick/ revert machinery how to replay the changes, and
> initializes them by parsing the command-line arguments.  In later
> steps in this series, we would like to introduce an API function that
> calls into this machinery directly and have a way to tell it what to
> do.  Hence, introduce a structure to group these variables, so that
> the API can take them as a single replay_options parameter.

The struct leaves out the variable "me".  A person might wonder why
the above rationale applies to the other variables but not that one. :)

> Unfortunately, parsing strategy-option violates a C89 rule:
> Initializers cannot refer to variables whose address is not known at
> compile time.

Reading this, one is led to wonder:

 - is this a regression?
 - is it a necessary consequence of the positive change?
 - will it matter --- i.e., does the rest of git follow that rule to
   be able to build on old-fashioned compilers, and is there any
   intention to?
 - how can I get my compiler to tell me about it?
 - is it fundamental or not?  i.e., is this a "we introduced this
   minor regression and expect it will be fixed later" or "this points
   to a flaw in the design and we hope someone comes up with a better
   design that doesn't have that problem"?

By the way, as a side note, here are a couple of patches about the
same subject that I use to test with "-std=c89 -pedantic" privately.

 http://repo.or.cz/w/git/jrn.git/commit/faa4b89731e5411fbdf6812f11748a20e664361d
 http://repo.or.cz/w/git/jrn.git/commit/92a0c179cb7690bdf6f8fbbfa2253b883d02bd17
