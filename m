From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 12:05:59 -0400
Message-ID: <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
References: <20070529071622.GA8905@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Dana How" <danahow@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 18:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht4DA-0005qL-7H
	for gcvg-git@gmane.org; Tue, 29 May 2007 18:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXE2QGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbXE2QGG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 12:06:06 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:9813 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXE2QGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 12:06:03 -0400
Received: by an-out-0708.google.com with SMTP id d31so547934and
        for <git@vger.kernel.org>; Tue, 29 May 2007 09:06:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tHlGV9Bw14Qtc204HBNs8PECY4UxhQfO8vY8DzxhqwHE0bzwIMMnzuzfOns2pcHK4j6Pibsfyq5LY+xw6p9pvvhiidiSjK0NCMhEpDeg4E4uMasAbGTx6M0N0iX+338uF0SNikyhtYlL8n4X2tSlYWPbD8mdsZ8Nk+fQpYcnchs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cmLW0AWq8bWlFZ+V6Mm62mqZIXB1ovGMIfpfcHPj/OI+bOEtAWPfEdVSFfUDRIVCWorWKosV1ZnLMQiMeWEyDFORLEw7V7xgH9XI1hGTlxsJKbZwj5C0F73XulDIEcIYU9/fnGJvfuCaidgAZOH1Tl7swxYpQZxhXEwnqozK1Dg=
Received: by 10.115.110.6 with SMTP id n6mr3472625wam.1180454759999;
        Tue, 29 May 2007 09:05:59 -0700 (PDT)
Received: by 10.114.195.13 with HTTP; Tue, 29 May 2007 09:05:59 -0700 (PDT)
In-Reply-To: <20070529071622.GA8905@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48699>

Object's are not accessed in random order with git. Once an object
reference hits a pack file it is very likely that following references
will hit the same pack file. That's because you always find object
SHA's by following the chains.

So first place to look for an object is the same place the previous
object was found. If it isn't there order the search of the pack files
by creation data (just a heuristic). Make this list a circle and start
the search in the pack where the previous object was found. This can
all be done with the existing indexes.

I haven't been reading all of the messages on this subject, but is
this strategy enough to eliminate the need for a super index?

If you still need a super index, note that it may be good enough for
it to only contain the SHA's for objects that are externally
referenced. This index would be small and simply point to the correct
pack file index to find the object in. You could add a list of
dangling links to each packfile index to assist with building this
super index.

My work with databases leads me to believe that figuring out how to
pack everything into a smaller space always beats efforts put into
incrementally improving the indexing scheme. Packing into a smaller
space reduces the total IO needs and that's always a winner.

-- 
Jon Smirl
jonsmirl@gmail.com
