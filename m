From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 12:53:20 -0500
Message-ID: <20100317175320.GA26124@progeny.tock>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
 <1268768556-32176-1-git-send-email-marcnarc@xiplink.com>
 <20100316214717.GA24880@progeny.tock>
 <4BA0FBC7.3080305@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 18:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrxQX-0005ew-9I
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab0CQRw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 13:52:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43097 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab0CQRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 13:52:57 -0400
Received: by pva4 with SMTP id 4so681036pva.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DaSJkLo7pHzeflAxfD5vZv9uQlDqwCWAri3vWMavY1w=;
        b=SeDsUbwgDhl+e/PBBzb9YkmOLEStZ4OSebURdZ+LneTs6meaQ7L3b4H9MgxvoLPb80
         RXv3qQGGih+hK5UyBFnXtjanQWjsmniz5nk0g4rkPkcbZqGagl+sQJe6BHy72guAYBYA
         0yVjZwJlbxthzDfOA+Jc/OlDM2mu0DVHBkxqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XqncGYCnwdDqs6mo+ELUkoAbSEJxbj8sfBAdw+aBYYzjxUANq4YCZ36O8tn2iPsxLf
         SigRgUFntVr6U6lPAYEkDUWiBJzXIRSIy6ij/4DO+s5wnATy3gdW8G67bK4f05jpXdOz
         TTJ1+l8Rdy+1aBtnHkj6mLrJw0slZgIaWlZE4=
Received: by 10.140.247.21 with SMTP id u21mr1257264rvh.250.1268848375755;
        Wed, 17 Mar 2010 10:52:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6586034iwn.7.2010.03.17.10.52.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 10:52:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BA0FBC7.3080305@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142420>

Marc Branchaud wrote:

> If the re-cast topic1 doesn't rewrite those commits, then the merge w=
ill
> simply succeed because the code is already identical in both branches=
=2E
>=20
> But if topic1 does rewrite those commits then there'll be a conflict.=
  IMO
> that's correct, because with the merging of topic2 the code in master=
 really
> did diverge in a relevant way from what's in topic1, so that conflict=
 should
> get resolved in the normal way.

Sorry, I did not think it through all the way.  Here is an example of
what I meant by trouble.  Suppose you have re-cast topic using
rebase --no-ff:

   B' --- C' --- D' [topic]
  /
 | B --- C --- D         F [topic2]
 |/             \       /
 A ---  ...  --- M --- E ... --- U [master]

topic represents a new feature that was merged prematurely and then
reverted, and topic2 represents some helpful new plumbing.
(introduction of a few functions, maybe).

To take advantage of the changes from F, someone merges topic2 into
topic and builds on it:

                    .. X --- Y [topic]
                   /  /
   B' --- C' --- D'  F [topic2]
  /                 /
 A -- ... -- M --- E ... --- U [master]

Now someone decides it is time to merge topic into master.  The
merge-base for Y and U is E, and the result is a that the changes from
topic are reverted.

What I had missed: it would be just as dangerous to simply merge topic2
directly.  Merging =E2=80=98master=E2=80=99 into =E2=80=98topic=E2=80=99=
 does nothing to prevent that.

The new advice: when using rebase --no-ff this way, be sure to rewrite
_every_ branch that includes those commits but doesn=E2=80=99t include =
U.

Jonathan
