From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Fri, 21 Aug 2009 01:22:35 +0200
Message-ID: <c77435a80908201622o7d69681ftda0ca63c5a915f4b@mail.gmail.com>
References: <op.uys3qwlmtdk399@sirnot.private>
	 <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
	 <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
	 <alpine.LFD.2.00.0908182313100.6044@xanadu.home>
	 <c77435a80908200543h74fdb07dm7f30cee4fedef8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGxx-0002xh-UX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbZHTXWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbZHTXWg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:22:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:31869 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbZHTXWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:22:35 -0400
Received: by ey-out-2122.google.com with SMTP id 22so106787eye.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AiWbzk+4Hf9z9Tt7CdtuAKxefA2TcB1hcirJEoOkSZI=;
        b=wkRDA+XeSytVcwM+HjkIrAGp1wYamqDFuY146iBWAbDdZNKAVvqq1bDHlvA+MkWxjp
         ACh9Ilk+5GHNuxmTATl/c/0qgplkYsyGM5wybK3Xnlom7BPkWY0OTABD9CIq+8eoezdJ
         /TWNSjVf3FKAJ0kPdoCzisHkc8aKDWOVFwYqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vWXbeZAGbzcDxelhL4pegbxd3VoAKCHqRn3Clt8fEBkCk2GzjF7Esaz/0mEtVJE2xi
         zWBiTZt3pbEbZDGtkpRvaF8F4U/QwFsXFb/1CbCXh3DdIhLDg/KgTjlrVa5mEq8xveI0
         GjA1mxiZks2ehCAKPwGRojGtwZUYVUquHD3XI=
Received: by 10.216.1.202 with SMTP id 52mr80325wed.15.1250810555675; Thu, 20 
	Aug 2009 16:22:35 -0700 (PDT)
In-Reply-To: <c77435a80908200543h74fdb07dm7f30cee4fedef8c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126660>

Ok we actually have a small problem, semi-related to the object
listing.  By default rev-list will list everything not seen in each
tree, whereas rev-cache will only list object introduced in a given
commit.  This becomes problematic if you have two different files with
the same content in the same tree: rev-cache will show the name of the
youngest file; vanilla rev-list will list the name soonest encountered
in the tree (which can even change if, e.g., a subdir is renamed so as
to be list in a different order).

In fact, even if they're not in the same tree we could have a similar
problem.  Commits are stored topologically in cache slices, so output
is always in topo order.  If the same object is introduced in parallel
branches under different names, the outputted name with `rev-list
--all --objects` (vanilla) could be different from `rev-list --all
--objects` (cached) could be different from `rev-list --all
--topo-order --objects`.

This isn't feasably changable in rev-cache, as a) the cached position
(and hence final output order) is effectively unrelated to tree
structure, and b) commits _have_ to be ordered topologically for
rev-cache to function.

The descrepency strikes me as something of a non-issue with
pack-objects' deltafication, as the object will fit with either of its
names.  It will mean that the (already sorta finicky) object names
won't have garuanteed consistency between cached/non-cached calls to
rev-list.  This is something of a corner case and dosn't strike me as
a huge issue, but I figured I should consult you all before presuming
things about git's interface.

 - Nick
