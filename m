From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] Make pack creation always fsync() the result
Date: Fri, 30 May 2008 16:27:01 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805301620040.23581@xanadu.home>
References: <20080529205743.GC17123@redhat.com>
 <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
 <20080530152527.GF4032@redhat.com>
 <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 22:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BCe-0001tL-Ea
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbYE3U1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYE3U1E
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:27:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9308 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYE3U1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:27:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K1P003WR7H1HJ20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 30 May 2008 16:27:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83324>

On Fri, 30 May 2008, Linus Torvalds wrote:

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 70d2f5d..4c2e0cd 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -515,10 +515,12 @@ static void write_pack_file(void)
>  		 * If so, rewrite it like in fast-import
>  		 */
>  		if (pack_to_stdout || nr_written == nr_remaining) {
> -			sha1close(f, sha1, 1);
> +			unsigned flags = pack_to_stdout ? CSUM_CLOSE : CSUM_FSYNC;
> +			sha1close(f, sha1, flags);
>  		} else {

Micro nit:  wouldn't it look more obvious if it was written as:

	if (pack_to_stdout) {
		sha1close(f, sha1, CSUM_CLOSE);
	} else if (nr_written == nr_remaining) {
		sha1close(f, sha1, CSUM_FSYNC);
	} else {
		...

Otherwise looks sane to me.


Nicolas
