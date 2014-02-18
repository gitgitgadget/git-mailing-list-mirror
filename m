From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 11:25:03 +0100
Message-ID: <87ioscsoow.fsf@fencepost.gnu.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 11:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFhrV-0003Qt-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 11:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbaBRKZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 05:25:07 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:33583 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbaBRKZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 05:25:05 -0500
Received: from localhost ([127.0.0.1]:60858 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFhrM-00011J-8I; Tue, 18 Feb 2014 05:25:04 -0500
Received: by lola (Postfix, from userid 1000)
	id DE411E0487; Tue, 18 Feb 2014 11:25:03 +0100 (CET)
In-Reply-To: <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 18 Feb 2014 16:45:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242293>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 18, 2014 at 3:55 PM, David Kastrup <dak@gnu.org> wrote:
>
>> I've seen the same with my ongoing work on git-blame with the current
>> Emacs Git mirror.  Aggressive packing reduces the repository size to
>> about a quarter, but it blows up the system time (mainly I/O)
>> significantly, quite reducing the total benefits of my algorithmic
>> improvements there.
>
> Likely because --aggressive passes --depth=250 to pack-objects. Long
> delta chains could reduce pack size and increase I/O as well as zlib
> processing signficantly.

Increased zlib processing time is one thing, but if it _increases_ I/O,
then it would seem there is a serious impedance mismatch between the
compression scheme and the code relying on it, leading to repeated reads
of blocks only needed for reconstructing dynamic compression
dictionaries.

Compression should reduce rather than increase the total amount of
reads.  So it would seem that either better caching and/or smaller
independent block sizes and/or strategies for sorting the delta chain to
make its resolution require mostly linear reads, and then make sure to
do this in a manner that does not reinitialize the decompression for
accessing each delta that happens to be more or less "in sequence".

Of course, this is assuming that the additional time is spent
uncompressing data rather than navigating directories.

It's actually conceivable that there is quite a bit of potential to get
better performance from unchanged readers by packing stuff in a
different order while still using the same delta chain depth.

-- 
David Kastrup
