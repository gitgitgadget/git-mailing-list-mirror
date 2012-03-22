From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 22 Mar 2012 23:51:37 +0100
Message-ID: <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAqrJ-0003KB-QR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030728Ab2CVWvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:51:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57907 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2CVWvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 18:51:48 -0400
Received: by gghe5 with SMTP id e5so2297260ggh.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=MkHVTz4xZ/bDtuiYUnmoe98YVN2VcmZJaOwW2ezsJ7k=;
        b=j2lmh7NySjfHrEn2yHLwIbbaDCDtWSG4Tq7kanCioo/WoAe3puLJR3QJNMPXmkZlR+
         UGaRdC7yVK+VPhrL8mkhHsaTE6jKatLbxkV/zogXTfy7S8h31F0PXcIGvY7FguBZFDaZ
         V4f+IKxYyPnG1QNyeLwf8x9hJDgNOArX1LqKmN1xJtrJnqY/Rh08ScRvwa6vNjdv5d9S
         Clp3HjM+RiIuwVTd7NxWRT7VgQzHyqu9EM63lF+WvqofusQpn/B4js9PXCYtVoM0Qm7B
         hHRaslajyzEv6iXcdqYYEbytO2UnbpphV+q84bl2lPm0PeXqG3uc5cRfvdtEyD7IGBFr
         IqRA==
Received: by 10.60.13.37 with SMTP id e5mr2538471oec.70.1332456706693;
        Thu, 22 Mar 2012 15:51:46 -0700 (PDT)
Received: from [192.168.10.2] ([216.18.212.218])
        by mx.google.com with ESMTPS id m3sm4774987oem.7.2012.03.22.15.51.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 15:51:45 -0700 (PDT)
In-Reply-To: <871uomq64c.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193724>

As suggested on IRC, here is my first draft proposal. Should the proposal 
include more more technical material already, or just the general sketch of 
the project?

Designing a faster index format

-- Problem --
The current git index is pretty slow when working with large git repositories,
because the whole index has to be rewritten for nearly every operation. For
example for adding a single file with git add, even though only one single blob
sha-1 is changed in the index, the way it's currently implemented git will need
to recompute a new hash over the whole index.

-- Proposed solution --
The proposed solution is to rework the index, in order to make it possible to
have a complexity of O(log(n)), where n is the number of index entries, for 
simple operations like adding files. 

The data format will also be easily parsable in order to make it easier for
programs, that read the index (like jgit or libgit2), to adapt to the new 
format.

The solution would consist of two steps. In the first step the index on the
filesystem would be replaced, but not mmap'd for direct access, which would 
mainly save on I/O operations. In the second step the core parts would also be
made aware of the new index, as it would be mmap'd for direct access.

Another way to speed up the hashing would be to exchange the SHA-1 hash for
something faster. That may however not be feasible when keeping the current
in-memory structure.

To make the project feasible for Google Summer of Code, the plan is to
implement the first part and if this goes smoother then expected and there is
still time left, the second part should also be implemented as extra work.

-- Timeline --
24/04 - 12/05: Getting familiar with the old index
13/05 - 26/05: Come up with a exact plan for the new index and document it.
Check feasibility of exchanging SHA-1 with a faster checksum algorithm.
27/05 - 30/06: Writing the new index format to disk and making it only rewrite 
the parts that really need to be changed (Should be less writes then currently
necessary).
/* Development work will be a bit slower from 18/06 to 21/07 because at my
 * University there are exams in this period. I probably will only be able to
 * work half the hours. I'll be back up to full speed after that. */
31/06 - 28/07: Parse the index from the disk to the current in-memory format.
29/07 - 13/08: Optimize the algorithm and profile the gains. 

-- Why git --
I'm using git since about 2-3 years and wanted to contribute to it earlier, but
couldn't find the time to do it. I would also like to continue contributing
once the Summer of Code is over.