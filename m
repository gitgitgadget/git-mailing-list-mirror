From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff: fix "git show -C -C" output when renaming a binary file
Date: Thu, 3 Jun 2010 06:12:35 +0200
Message-ID: <201006030612.35931.chriscool@tuxfamily.org>
References: <20100526025013.25696.26816.chriscool@tuxfamily.org> <7v4ohl9f8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Greg Bacon <gbacon@dbresearch.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 06:12:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK1nY-000251-SY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 06:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921Ab0FCEMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 00:12:47 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58175 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab0FCEMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 00:12:47 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C7E0181802D;
	Thu,  3 Jun 2010 06:12:38 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7v4ohl9f8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148288>

On Thursday 03 June 2010 01:38:55 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > A bug was introduced in 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
> > (No diff -b/-w output for all-whitespace changes, Nov 19 2009)
> > that made the lines:
> >
> > diff --git a/bar b/sub/bar
> > similarity index 100%
> > rename from bar
> > rename to sub/bar
> >
> > disappear from "git show -C -C" output when file bar is a binary
> > file.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  diff.c                        |    4 +++
> >  t/t4043-diff-rename-binary.sh |   45
> > +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 49
> > insertions(+), 0 deletions(-)
> >  create mode 100755 t/t4043-diff-rename-binary.sh
> >
> > diff --git a/diff.c b/diff.c
> > index 494f560..0b00271 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1737,6 +1737,10 @@ static void builtin_diff(const char *name_a,
> >  						textconv_one, textconv_two, o);
> >  			o->found_changes = 1;
> >  			goto free_ab_and_return;
> > +		} else if (diff_filespec_is_binary(one) &&
> > +			   diff_filespec_is_binary(two)) {
> > +			fprintf(o->file, "%s", header.buf);
> > +			strbuf_reset(&header);
> >  		}
> 
> Actually, the logic to single out "binary vs binary" feels wrong, as one
> of the cases the output that was overly squelched is this one:
> 
> 		/* Quite common confusing case */
> 		if (mf1.size == mf2.size &&
>        	            !memcmp(mf1.ptr, mf2.ptr, mf1.size))
> 			goto free_ab_and_return;
> 		fprintf(o->file, "%s", header.buf);
> 		strbuf_reset(&header);
> 
> Notice that we have accumulated the rename/copy/new/old in header but if
> the blobs are the same, we discard it.
> 
> Another case that 3e97c7c6 handled completely incorrectly is when -w/-b is
> in effect and there is a rename or copy.  Because there won't be textual
> diff emitted by fn_out_consume() at all, we lose the header information as
> well.
> 
> So I would say we would need something like this on top of your patch.

I agree, your fix looks right.

Thanks,
Christian.
