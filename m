From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/9] add test for streaming corrupt blobs
Date: Wed, 27 Mar 2013 16:27:05 -0400
Message-ID: <20130327202705.GA5145@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202134.GE16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwwd-0002Xv-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab3C0U1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:27:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41888 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab3C0U1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:27:11 -0400
Received: (qmail 18264 invoked by uid 107); 27 Mar 2013 20:28:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 16:28:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 16:27:05 -0400
Content-Disposition: inline
In-Reply-To: <20130325202134.GE16019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219324>

On Mon, Mar 25, 2013 at 04:21:34PM -0400, Jeff King wrote:

> +# Convert byte at offset "$2" of object "$1" into '\0'
> +corrupt_byte() {
> +	obj_file=$(obj_to_file "$1") &&
> +	chmod +w "$obj_file" &&
> +	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
> +}

Hmm, this last line should probably be:

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index a84deb1..3f87051 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -12,7 +12,7 @@ corrupt_byte() {
 corrupt_byte() {
 	obj_file=$(obj_to_file "$1") &&
 	chmod +w "$obj_file" &&
-	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
+	printf '\0' | dd of="$obj_file" bs=1 seek="$2" conv=notrunc
 }
 
 test_expect_success 'setup corrupt repo' '

The intent was to change a single byte, not truncate the file (though on
the plus side, that truncation is what found the other bugs).

-Peff
