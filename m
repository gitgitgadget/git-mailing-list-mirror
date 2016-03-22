From: Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH v5] Add the option to force sign annotated tags
Date: Tue, 22 Mar 2016 21:07:24 +0100
Message-ID: <20160322200724.GH20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321192904.GC20083@spk-laptop>
 <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
 <20160321205015.GF20083@spk-laptop>
 <xmqqa8lrldz4.fsf@gitster.mtv.corp.google.com>
 <20160322193617.GG20083@spk-laptop>
 <xmqqshziguot.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiSaT-00086m-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbcCVUHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 16:07:30 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:39967 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcCVUH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 16:07:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id DFD63FF1DA;
	Tue, 22 Mar 2016 20:07:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqshziguot.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289554>

On Tue, Mar 22, 2016 at 12:48:50PM -0700, Junio C Hamano wrote:
> Laurent Arnoud <laurent@spkdev.net> writes:
> 
> > The `tag.forcesignannotated` config option allows to sign
> > annotated tags automatically.
> 
> It looks like it does a lot more than that to me, though.
> 
> > @@ -327,7 +333,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >  	char *cleanup_arg = NULL;
> >  	int create_reflog = 0;
> >  	int annotate = 0, force = 0;
> > -	int cmdmode = 0;
> > +	int cmdmode = 0, create_tag_object = 0;
> >  	const char *msgfile = NULL, *keyid = NULL;
> >  	struct msg_arg msg = { 0, STRBUF_INIT };
> >  	struct ref_transaction *transaction;
> > @@ -385,12 +391,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >  		opt.sign = 1;
> >  		set_signing_key(keyid);
> >  	}
> > -	if (opt.sign)
> > -		annotate = 1;
> > +	if (opt.sign || annotate || force_sign_annotate)
> > +		create_tag_object = 1;
> 
> This means that create_tag_object is always on if the configuration
> is set and there is no way to override that from the command line,
> doesn't it?  I cannot see how a user would create a lightweight tag
> if this configuration variable is set with this change.
> 
> I think it makes sense to have this here instead of these two lines:
> 
> 	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
> 
> >  	if (argc == 0 && !cmdmode)
> >  		cmdmode = 'l';
> >  
> > -	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
> > +	if ((create_tag_object || msg.given || msgfile || force) && (cmdmode != 0))
> 
> and then simplify this to
> 
> 	if ((create_tag_object || force) && (cmdmode != 0))
> 
> perhaps?  Then ...
> 
> >  		usage_with_options(git_tag_usage, options);
> >  
> >  	finalize_colopts(&colopts, -1);
> > @@ -431,7 +438,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >  	if (msg.given || msgfile) {
> >  		if (msg.given && msgfile)
> >  			die(_("only one -F or -m option is allowed."));
> > -		annotate = 1;
> > +		create_tag_object = 1;
> 
> ... this line can just go, as we are taking the presense of various
> ways to say "I'll give this message to the resulting tag" as the
> sign that the user wants to create a tag object much earlier.
> 
> >  		if (msg.given)
> >  			strbuf_addbuf(&buf, &(msg.buf));
> >  		else {
> > @@ -474,8 +481,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >  	else
> >  		die(_("Invalid cleanup mode %s"), cleanup_arg);
> >  
> > -	if (annotate)
> > +	if (create_tag_object) {
> > +		if (force_sign_annotate && !annotate)
> > +			opt.sign = 1;
> >  		create_tag(object, tag, &buf, &opt, prev, object);
> > +    }
> 
> And this hunk is OK.
> 
> > diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> > index cf3469b..be95318 100755
> > --- a/t/t7004-tag.sh
> > +++ b/t/t7004-tag.sh
> > @@ -775,6 +775,39 @@ test_expect_success GPG '-s implies annotated tag' '
> >  	test_cmp expect actual
> >  '
> >  
> > +get_tag_header config-implied-annotate $commit commit $time >expect
> > +./fakeeditor >>expect
> > +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> > +test_expect_success GPG \
> > +	'git tag -s implied if configured with tag.forcesignannotated' \
> > +	'test_config tag.forcesignannotated true &&
> > +	GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&
> 
> This contradicts with what you said earlier in your
> <20160321192904.GC20083@spk-laptop> aka
> http://thread.gmane.org/gmane.comp.version-control.git/289322/focus=289441
> 
>     > If you are forcing users to always leave a message and then further
>     > forcing users to always sign with the single new configuration, i.e.
>     > 
>     >     $ git tag v1.0
>     >     ... opens the editor to ask for a message ...
>     >     ... then makes the user sign with GPG ...
> 
>     I'm not forcing this type of user to enable global
>     configuration, that will be annoying for them of course.
> 
> But this test expects that this invocation of "git tag $tagname"
> forces the user to give a message with editor and sign it, instead
> of creating a lightweight tag.

Yes you're right, I will fix that...

-- 
Laurent
