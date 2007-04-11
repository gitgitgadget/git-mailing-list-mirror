From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rebase, please help
Date: Wed, 11 Apr 2007 11:10:14 +0100
Message-ID: <200704111110.18461.andyparkins@gmail.com>
References: <200704110852.00540.litvinov2004@gmail.com> <7v8xczqs1q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 15:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZmX-0005lq-F5
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 12:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXDKKKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 06:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXDKKKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 06:10:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:31164 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXDKKKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 06:10:23 -0400
Received: by ug-out-1314.google.com with SMTP id 44so82584uga
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 03:10:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h4kAzwaYClnGBg2AFXZUu50Odidv6hZSFHzsaNFlVYb3mxKYGYCFKd9fd6xeI2gHWikFTWroTxoC/QNyWkbUfD0bgqiqas5QjGzBej3pidjwh/pnkg5PjWXiihlVW95gN5YbS/fanl29eqCIIk52dGWaoc456hRjcJyFdYEYKy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bIpxUnSIZp6fjJlurmuWF41/fQLF6TNeg7I5lHnXtXWmXPiVjldKslGcduCBJwdL+q1DzH1mV2xNhP2iZHmYSt/HISjX8qvngAB6PLi3ATqfH1dIYL7uT59Jbowo/J3FqhVUOs5Dlz/f3DGlvF8aVixjHQ872No3HD669wtiA7I=
Received: by 10.67.92.1 with SMTP id u1mr340303ugl.1176286222739;
        Wed, 11 Apr 2007 03:10:22 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm678983ika.2007.04.11.03.10.21;
        Wed, 11 Apr 2007 03:10:22 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7v8xczqs1q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44231>

On Wednesday 2007 April 11 08:38, Junio C Hamano wrote:

> I find that the regular rebase without --merge is faster (at
> least it feels to me that it is, and I kind of understand why;

This is interesting and brings to mind a difficult I've had.  I had problems 
with rebase when rebasing chains with a file that was self-similar.  Indulge 
me for a while with this example (forgive the C++, but that's where I had 
this problem):

class A : public C
{
   // ...

   int someVirtualOverride(n) { return ArrayA[n]; }

   // ...
}

class B : public C
{
   // ...

   int someVirtualOverride(n) { return ArrayB[n]; }

   // ...
}

One patch changed "ArrayX[n]" to "Array.at(n)" and another inserted more 
similar classes around these two.

When I was rebasing, some strange things happened (without any conflict 
warnings):

class D : public C
{
   int someVirtualOverride(n) { return ArrayA.at(n); }
}

class A : public C
{
   int someVirtualOverride(n) { return ArrayB.at(n); }
}

class B : public C
{
   int someVirtualOverride(n) { return ArrayB[n]; }
}

Notice that the arrays don't match up with the classes.  By some crazy 
coincidence and the strong similarity between localities within the file, the 
patch successfully applied in the wrong place.  The fix was easy enough to do 
manually, but it needed a bit of untangling as this was in a longish chain of 
revisions that I was rebasing.

I didn't mind much, and hence didn't report it as a bug as I guessed it was to 
do with git-rebase using git-am.  The annoying part was actually that there 
was no conflict warning and hence the rest of the chain applied, making it 
all the more difficult to untangle.

My question then is this: given that I don't care about speed of rebase, is it 
safe to permanently use --merge with rebase, and would that have caught the 
error in the above case?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
