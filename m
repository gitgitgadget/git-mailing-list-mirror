From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 07:55:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mbl-0001ac-7j
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYKSMzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYKSMzW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:55:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45643 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYKSMzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:55:22 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAK00H0IZUNIQG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Nov 2008 07:54:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4923FE58.3090503@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101335>

On Wed, 19 Nov 2008, Johannes Sixt wrote:

> Alex Riesen schrieb:
> > The opened packs seem to stay open forever.
> 
> In my MinGW port I have the patch below that avoids that t5303 fails
> because of a pack file that remains open. (Open files cannot be replaced
> on Windows.) I had hoped that your patch would help, but it does not.
> Something else still keeps the pack file open. Can anything be done about
> that?
> 
> -- Hannes
> 
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Mon, 17 Nov 2008 09:25:19 +0100
> Subject: [PATCH] t5303: Do not overwrite an existing pack
> 
> This test corrupts a pack file, then repacks the objects. The consequence
> is that the repacked pack file has the same name as the original file
> (that has been corrupted).
> 
> During its operation, git-pack-objects opens the corrupted file and keeps
> it open at all times. On Windows, this is a problem because a file that is
> open in any process cannot be delete or replaced, but that is what we do
> in some of the test cases, and so they fail.
> 
> The work-around is to write the repacked objects to a file of a different
> name, and replace the original after git-pack-objects has terminated.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Acked-by: Nicolas Pitre <nico@cam.org>


> ---
>  t/t5303-pack-corruption-resilience.sh |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5303-pack-corruption-resilience.sh
> b/t/t5303-pack-corruption-resilience.sh
> index 5132d41..41c83e3 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -43,8 +43,11 @@ create_new_pack() {
> 
>  do_repack() {
>      pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
> -          git pack-objects $@ .git/objects/pack/pack` &&
> -    pack=".git/objects/pack/pack-${pack}"
> +          git pack-objects $@ .git/objects/pack/packtmp` &&
> +    packtmp=".git/objects/pack/packtmp-${pack}" &&
> +    pack=".git/objects/pack/pack-${pack}" &&
> +    mv "${packtmp}.pack" "${pack}.pack" &&
> +    mv "${packtmp}.idx" "${pack}.idx"
>  }
> 
>  do_corrupt_object() {
> -- 
> 1.6.0.4.1683.g35125
> 
> 


Nicolas
