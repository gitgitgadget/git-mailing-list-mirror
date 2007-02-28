From: linux@horizon.com
Subject: Re: pack v4 status
Date: 28 Feb 2007 05:04:56 -0500
Message-ID: <20070228100456.13486.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 28 12:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMMjT-0006Fj-MP
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 12:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXB1LMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbXB1LMW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 06:12:22 -0500
Received: from science.horizon.com ([192.35.100.1]:16543 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752126AbXB1LMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 06:12:21 -0500
Received: (qmail 13487 invoked by uid 1000); 28 Feb 2007 05:04:56 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40914>

Just a minor note:

I you want to have an arbitrary-sized string table without special cases,
the standard binary Huffman tree construction algorithm can be extended
quite simply to a radix-256 tree, so every code is an integer number
of bytes long.

Take the input strings, and sort them in order of frequency of appearance.
Pad them at the end with dummy strings (frequency = 0) until the number
equals 1 mod 255.

Then take the last (least frequent) 256 strings off the list, and
replace them with a single prefix whose frequency is the sum of all of
the components.  Each of the selected strings will be encoded as the
prefix (whose code has not yet been decided) plus 256 possible byte values.
Insert the new prefix into the list in sorted order.

Repeat until the list has only one entry, which is represented by a
zero-length prefix.  (Since each step replaces 256 entries by 1 entry,
the number of entries never changes mod 255, so the algorithm always will
converge to one entry.)


This is generally encoded more compactly as a "canonical Huffman tree".
For each string, forget the actual encoding decided on here, and just
remember the number of bytes assigned to encode it; this is the only
number you need to record to reconstruct the tree for decoding.
Then count the number of strings to be encoded with 1, 2, 3... bytes.

To decode, read one byte.  If the byte is less than the number of 1-byte
strings, its value is the string's position in the 1-byte string table.

If the byte is >= the number of 1-byte strings, subtract the number of 1-byte
strings, multiply by 256, and add a following byte.  This is the position in
the 2-byte string table.

If the value is >= the number of 2-byte strings, subtract, multiply by
256, and add another trailing byte.  This is the position in the 3-byte
string table.  Repeat as necessary.


There are elaborations on this to bound the maximum number of bytes
required; see the zlib source for details.

If you have a significant number of unique (frequency == 1) strings,
you can encode them in-line after a common "unique string" prefix
(which can have a frequency greater than 1).


I'm not sure if you can follow all that (it helps to understand Huffmann
trees already), but I can explain at greater length if necessary.
The important thing is that it's quite straightforward and provides
a general solution.
