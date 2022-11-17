Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E310C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 10:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiKQKWc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 17 Nov 2022 05:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 05:22:31 -0500
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 02:22:28 PST
Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9034D5FA
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:22:28 -0800 (PST)
Received: from localhost (nb-ana002.math.uni-hannover.de [130.75.46.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy08.manitu.net (Postfix) with ESMTPSA id 686A91B2016E;
        Thu, 17 Nov 2022 11:13:13 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <221117.86wn7tj4af.gmgdl@evledraar.gmail.com>
References: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu> <221117.86wn7tj4af.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH] notes: avoid empty line in template
From:   Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
Message-ID: <166867999215.10813.7408480606700051633.git@grubix.eu>
Date:   Thu, 17 Nov 2022 11:13:12 +0100
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 2022-11-17 10:48:48:
> 
> On Wed, Nov 16 2022, Michael J Gruber wrote:
> 
> > When `git notes` prepares the template it adds an empty newline between
> > the comment header and the content:
> >
> >>
> >> #
> >> # Write/edit the notes for the following object:
> >>
> >> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
> >> # etc
> >
> > This is wrong structurally because that newline is part of the comment,
> > too, and thus should be commented. Also, it throws off some positioning
> > strategies of editors and plugins, and it differs from how we do commit
> > templates.
> >
> > Change this to follow the standard set by `git commit`:
> 
> I don't mind the consistency here, but what does "wrong structurally"
> mean? Doesn't the usual removing of duplicate newlines make this amount
> to the same?

I am talking about what we present to the user as a template, and that
contains two newlines. Whether they will be reduced afterwards depends
on the cleanup policy.
 
> >> #
> >> # Write/edit the notes for the following object:
> >> #
> >> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
> >>
> >
> > Tests pass unchanged after this code change.
> 
> Because it did change something and we've got bad test coverage, or just
> because it's really a stylistic change?
> 
> I don't mind it being a stylistic change, but the proposed commit
> doesn't really make that clear, and leaves one wondering about potential
> missing test coverage etc.

Yes, missing, as noted by peff also. We do test the resulting notes
objects, and those tests pass unchanged which proves that the code
changes only what we present to the user in the template, not what we
create in the object store.
 
> > Signed-off-by: Michael J Gruber <git@grubix.eu>
> > ---
> >  builtin/notes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index be51f69225..80d9dfd25c 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -181,7 +181,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
> >               strbuf_addch(&buf, '\n');
> >               strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
> >               strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
> > -             strbuf_addch(&buf, '\n');
> > +             strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
> >               write_or_die(fd, buf.buf, buf.len);
> 
> Nothing new as the pre-image shows, but I wondered why not just add a
> "#\n", before I remembered core.commentChar, so this is correct.

Introduction of that feature was the source of all these lines in the
preimage, but due to the extent of the proposed cosmetic change I passed
on the usual blaming business.

Michael
