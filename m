From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name
Date: Tue, 06 Jan 2009 00:18:51 -0800
Message-ID: <7vocykkftg.fsf@gitster.siamese.dyndns.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
 <20090104033839.GD21154@genesis.frugalware.org>
 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
 <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
 <1a69a9d80901041223r1f3d2956ne05996793bb23e97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Karl Chen" <quarl@cs.berkeley.edu>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Arnaud Lacombe" <lacombar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7Ak-0007lM-E0
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbZAFITB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbZAFITB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbZAFITA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A71738DE8E;
	Tue,  6 Jan 2009 03:18:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 54F258DE8D; Tue,
  6 Jan 2009 03:18:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB69EFDE-DBCA-11DD-A254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104655>

"Arnaud Lacombe" <lacombar@gmail.com> writes:

> You'll find hereafter two patches which implements this in
> git-symbolic-ref and git-rev-parse. Feel free to choose the one you
> find the best. If you choose to integrate one of these, tells me and
> I'll do a proper documentation bits and patch submission.

> diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
> index 81d5a6f..70f4a33 100644
> --- a/builtin-rev-parse.c
> +++ b/builtin-rev-parse.c
> @@ -24,6 +24,7 @@ static int show_type = NORMAL;
>  
>  #define SHOW_SYMBOLIC_ASIS 1
>  #define SHOW_SYMBOLIC_FULL 2
> +#define SHOW_SYMBOLIC_SHORT 3
>  static int symbolic;
>  static int abbrev;
>  static int output_sq;

I think --symbolic-short makes the most sense.

> @@ -125,13 +129,20 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
>  				 */
>  				break;
>  			case 1: /* happy */
> +				if (symbolic == SHOW_SYMBOLIC_SHORT) {
> +					char *p;
> +					p = strrchr(full, (int)'/');
> +					if (p != NULL)
> +						full = p + 1;
> +				}

However, this is not a good way to do it, I suspect.  This patch most
likely will be queued to the al/symbolic-short topic branch, but you are
losing information here.  You'd probably want to try substings from the
tail of the full name (e.g. symbolic-short, al/symbolic-short,
heads/al/symbolic-short, and finally refs/heads/al/symbolic-short) and
feed them to dwim_ref() and pick the shortest one that yields the same ref
unambiguously, or something like that.

By the way, I do not see why you need to cast '/'.
