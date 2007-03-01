From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] pathattr: path based configuration of various attributes.
Date: Thu, 1 Mar 2007 09:11:54 +0000
Message-ID: <200703010911.56048.andyparkins@gmail.com>
References: <7vps7txwie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhKY-0002Tn-F3
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbXCAJMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933177AbXCAJMF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:12:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:50308 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174AbXCAJMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:12:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so831982nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:12:00 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tmyJ0kKKGhmsle6I0I8S/en43iOMvjibLIO9YkGxp2KAxHWVj2IVS8Rwcd03OoWezN2WBEnyJPrUAmC8Rdnb/dLyZjxonUyf9Ft2hSk6qZGIJetr7wc0SgABR0P7H3XlflAiqLUnww7Tct7vP2WimeKZ3B9e6gqrfS3p9Ep3vKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PKy+q89ZgEV2LAaLj5NnKd/RcWeMm/LxwbxA88rOY1KmmtZDFF2BK5v0vSKoTcDcxLcMkU/9Kw16Z8FgM1qW+g44RIUokcxtVguPlZ7lvO5xC9l9K3/6YvFFObiyT3O1+9DfPhQS3EEQYYLfny92MT33i+x349ObHY88OIsgiHI=
Received: by 10.49.13.19 with SMTP id q19mr5261071nfi.1172740320653;
        Thu, 01 Mar 2007 01:12:00 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id a24sm8407191nfc.2007.03.01.01.11.58;
        Thu, 01 Mar 2007 01:11:58 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vps7txwie.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41058>

On Thursday 2007 March 01 07:18, Junio C Hamano wrote:

> 	[pathattr "text/plain"]
>         	conv_i = crlf
> 		path = "*.txt"
>                 path = "*.c"
>                 path = "*.h"

Can I suggest that "crlf" is not the right name for something like this?  What 
you actually want is to say

 conv_i = convert_from_local_lineendings
 conv_o = convert_to_local_lineendings

(Obviously I'm not really suggesting such long names).  "crlf" implies that 
you want to convert to crlf endings /whatever/ the local line ending.  Given 
that exactly the same .gitattributes would be in use on both windows and 
linux for the same repository, it's got to be an attribute name that makes 
sense in both cases.  How about:

 conv_i = eol_to_lf
 conv_o = eol_to_local

I'm not sure about "conv" either.  "filter" would be more accurate.

 infilter = eol_to_lf
 outfilter = eol_to_local

--- Wild rantings start here, ignore at will ---

Also; for things like Ted's example of OpenDocument files, you might want

 infilter = gunzip
 outfilter = gzip

Then of course, order has to be significant:

 infilter = gunzip eol_to_lf
 outfilter = eol_to_local gzip

(That's probably a crazy thing to want to do, but it would make git 
spectacularly impressive).  Here's another idea, what about making the 
filters configurable, with some builtin (and overridable)

[infilter "perfectpatch"]
  exec = hooks/perfectpatch

[infilter "codingstandards"]
  exec = scripts/check-for-spaces-in-the-wrong-place

[pathattr "text/c"]
  infilter = perfectpatch
  path = *.cc
  path = *.cpp
  path = *.c
  path = *.C
  path = *.h

We could also support a prettyfilter for getting your display example from 
patch 2/2 in the right place.

[prettyfilter]
  exec = display -

[pathattr "image/"]
  prettyfilter = rundisplay
  path = *.png

Which would be equally good for fixing line endings for display; prettyfilter 
could, I suppose, default to be the same as outfilter, which would be correct 
in most cases.

[pathattr "text/c"]
  prettyfilter = eol_to_local

Sorry for the long rambling email, it's very exciting this attribute stuff.  I 
already love it.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
