From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 12:14:14 +0100
Message-ID: <201002141214.15025.trast@student.ethz.ch>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100214021847.GA9704@dpotapov.dyndns.org> <7v8wawy0ee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:14:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgcR2-00007F-B2
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab0BNLOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:14:40 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7988 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0BNLOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:14:39 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 12:14:37 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 12:14:15 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7v8wawy0ee.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139896>

On Sunday 14 February 2010 04:14:01 Junio C Hamano wrote:
> Later, we might want to split the codepath again to:
> 
>  (0) see if it is huge or small if we are not reading from pipe;
> 
>  (1) if we do not know the size or if it is moderately tiny, keep doing
>      what your code does;
> 
>  (2) if we know we are reading something huge with known size, then have a
>      loop to read-a-bit-compress-and-write-it-out-while-hashing, and
>      finally rename the loose resulting object to the final name.  Or we
>      may even want to do that into a new pack on its own.

There's a slight problem with that code (I tried to finish last
night's attempt but got stuck on this):

The create_tmpfile() and move_temp_to_file() duo goes to some lengths
to ensure that the file is created in the same directory that we want
it to end up in.  However, in the block-based scheme, you cannot know
which directory this will be before you have already written the
entire output.

So again I guess there are a few possible solutions:

* Try the cross-directory rename anyway, but if it doesn't work,
  copy&unlink.  This of course means that you may write the same
  object over network twice.

* Declare that keeping the memory usage near what it is today (the
  full output buffer plus a constant) is okay.

* Give up and stick with Dmitry's patch :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
