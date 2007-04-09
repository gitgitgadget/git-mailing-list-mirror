From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 06/10] pack-objects: learn about pack index version 2
Date: Sun, 08 Apr 2007 22:32:16 -0700
Message-ID: <7vabxi6rkv.fsf@assigned-by-dhcp.cox.net>
References: <11760951973172-git-send-email-nico@cam.org>
	<11760951973319-git-send-email-nico@cam.org>
	<11760951993458-git-send-email-nico@cam.org>
	<11760951993225-git-send-email-nico@cam.org>
	<11760951993409-git-send-email-nico@cam.org>
	<11760952002687-git-send-email-nico@cam.org>
	<11760952002410-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HamUX-0008Sc-PK
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbXDIFcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbXDIFcS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:32:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63438 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbXDIFcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:32:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409053218.MCCL24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 01:32:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ktYH1W0011kojtg0000000; Mon, 09 Apr 2007 01:32:17 -0400
In-Reply-To: <11760952002410-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Mon, 09 Apr 2007 01:06:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44040>

Nicolas Pitre <nico@cam.org> writes:

> Support for large packs exceeding 31 bits in size won't impose an index
> size bloat for packs within that range that don't need a 64-bit offset.
> And because newer objects which are likely to be the most frequently used
> are located at the beginning of the pack, they won't pay the 64-bit offset
> lookup at run time either even if the pack is large.
>
> Right now an index version 2 is created only when the biggest offset in a
> pack reaches 31 bits.  It might be a good idea to always use index version
> 2 eventually to benefit from the CRC32 it contains when reusing pack data
> while repacking.
> ...
> @@ -582,6 +602,18 @@ static void write_index_file(void)
>  	struct object_entry **list = sorted_by_sha;
>  	struct object_entry **last = list + nr_result;
>  	uint32_t array[256];
> +	uint32_t index_version;
> +
> +	/* if last object's offset is >= 2^31 we should use index V2 */
> +	index_version = (objects[nr_result-1].offset >> 31) ? 2 : 1;

Although write_pack_file() iterates objects[] array in the
ascending order of index and calls write_one() for each of them,
in the presense of "we write base object before delta" rule, is
it always true that the last object in the objects[] array has
the largest offset?
