From: Geert Bosch <bosch@adacore.com>
Subject: Re: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 23:58:57 -0500
Message-ID: <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com> <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com> <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com> <7vpq2f2az4.fsf@alter.siamese.dyndns.org> <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 06:08:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj11q-0006v3-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 06:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2LMFH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 00:07:56 -0500
Received: from rock.gnat.com ([205.232.38.15]:43185 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab2LMFH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 00:07:56 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2012 00:07:56 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 214372E217;
	Wed, 12 Dec 2012 23:58:56 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 54V8o83Whjv8; Wed, 12 Dec 2012 23:58:56 -0500 (EST)
Received: from [10.0.1.9] (sdsl-216-220-103-155.dsl.bway.net [216.220.103.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id CF8B22E209;
	Wed, 12 Dec 2012 23:58:55 -0500 (EST)
In-Reply-To: <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211434>


On Dec 12, 2012, at 20:55, Morten Welinder <mwelinder@gmail.com> wrote:
> I was merely asking if an algorithm to pick between the
> 2+ choices was allowed to look at the contents of the
> lines.
> 
> I.e., an algorithm would look at the C comment
> example and determine that the choice starting containing
> a full inserted comment is preferable over the one that
> appears to close one comment and open a new.
> 
> And the in inserted-function case it would prefer the one
> where the matching { and } are in correct order.

        /**                         +    /**                         
   +     * Default parent           +     * Default parent           
   +     *                          +     *                          
   +     * @var int                 +     * @var int                 
   +     * @access protected        +     * @access protected        
   +     * @index                   +     * @index                   
   +     */                         +     */                         
   +    protected $defaultParent;   +    protected $defaultParent;   
   +                                +                                
   +    /**                              /**                         

It would seem that just looking at the line length (stripped) of
the last line, might be sufficient for cost function to minimize.
Here the some would be 3 vs 0. In case of ties, use the last
possibility with minimum cost.

I think it would be nice if the cost function we choose does not
depend on file type, as that is something that is very dependent
on the exact local configuration and might hinder comparison of
patches. If something really simple gets us 90% there, that would
be preferable over extra complexity.

  -Geert

Junio's other example:

   }

  +void new_function(void)
  +{
  +  printf("hello, world.\n");
  +}
  +
   void existing_one(void)
   {
     printf("goodbye, world.\n");

=> Cost 0

  +}
  +
  +void new_function(void)
  +{
  +  printf("hello, world.\n");
   }
=> Cost 27

Kevin's example:
    /**
+     * Default parent
+     *
+     * @var int
+     * @access protected
+     * @index
+     */
+    protected $defaultParent;
+
+    /**

=> Cost 3

+   /**
+     * Default parent
+     *
+     * @var int
+     * @access protected
+     * @index
+     */
+    protected $defaultParent;
+
     /**
=> cost 0
