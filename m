Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B361FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcHILVv (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:21:51 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:52442 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcHILVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:21:50 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.73.8])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 1F076BF01A5;
	Tue,  9 Aug 2016 13:21:48 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bX56R-0002Gx-G0; Tue, 09 Aug 2016 14:21:47 +0300
Date:	Tue, 9 Aug 2016 14:21:47 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] pack-objects: teach it to use reachability bitmap
 index when generating non-stdout pack too
Message-ID: <20160809112143.GA21132@teco.navytux.spb.ru>
References: <20160808154054.GB3995@teco.navytux.spb.ru>
 <20160808185541.6433-1-kirr@nexedi.com>
 <xmqqbn13dltr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbn13dltr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 01:53:20PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index bc1c433..4ba0c4a 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2244,6 +2244,9 @@ pack.useBitmaps::
> >  	to stdout (e.g., during the server side of a fetch). Defaults to
> >  	true. You should not generally need to turn this off unless
> >  	you are debugging pack bitmaps.
> > ++
> > +*NOTE*: when packing to file (e.g., on repack) the default is always not to use
> > +	pack bitmaps.
> 
> This is a bit hard to read and understand.
> 
> The patched result starts with "When true, git will use bitmap when
> packing to stdout", i.e. when packing to file, git will not.  So
> this *NOTE* is repeating the same thing.  The reader is made to
> wonder "Why does it need to repeat the same thing?  Does this mean
> when the variable is set, a pack sent to a disk uses the bitmap?"
> 
> I think what you actually do in the code is to make the variable
> affect _only_ the standard-output case, and users need a command
> line option if they want to use bitmap when writing to a file (the
> code to do so looks correctly done).

Yes it is this way how it is programmed. But I've added the note because
it is very implicit to me that "When true, git will use bitmap when
packing to stdout" means 1) the default for packing-to-file is different
and 2) there is no way to set the default for packing-to-file. That's
why I added the explicit info.

And especially since the config name "pack.useBitmaps" does not contain
"stdout" at all it can be very confusing to people looking at this the
first time (at least it was so this way for me). Also please recall you
wondering why 6b8fda2d added bitmap support only for to-stdout case not
even mentioning about why it is done only for that case and not for
to-file case).

I do not insist on the note however - I only thought it is better to
have it - so if you prefer we go without it - let us drop this note.

Will send v6 as reply to this mail with below interdiff.

Thanks,
Kirill

---- 8< ---- (interdiff)

--- b/Documentation/config.txt
+++ a/Documentation/config.txt
@@ -2246,9 +2246,6 @@
        to stdout (e.g., during the server side of a fetch). Defaults to
        true. You should not generally need to turn this off unless
        you are debugging pack bitmaps.
-+
-*NOTE*: when packing to file (e.g., on repack) the default is always not to use
-       pack bitmaps.
 
 pack.writeBitmaps (deprecated)::
        This is a deprecated synonym for `repack.writeBitmaps`.
diff -u b/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
--- b/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -219,8 +219,8 @@
        # verify equivalent packs are generated with/without using bitmap index
        packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
        packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
-       git show-index <packa-$packasha1.idx | cut -d" " -f2 >packa.objects &&
-       git show-index <packb-$packbsha1.idx | cut -d" " -f2 >packb.objects &&
+       pack_list_objects <packa-$packasha1.idx >packa.objects &&
+       pack_list_objects <packb-$packbsha1.idx >packb.objects &&
        test_cmp packa.objects packb.objects
 '
