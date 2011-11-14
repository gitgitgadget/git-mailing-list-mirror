From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH, v2] tag: implement --[no-]strip option
Date: Tue, 15 Nov 2011 00:39:03 +0200
Message-ID: <20111114223903.GA5751@shutemov.name>
References: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
 <7vipmmibx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:39:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5BG-0005PN-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531Ab1KNWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:39:05 -0500
Received: from shutemov.name ([188.40.19.243]:40194 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1KNWjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:39:04 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 4A73F114001; Tue, 15 Nov 2011 00:39:03 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vipmmibx4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185410>

On Mon, Nov 14, 2011 at 02:20:23PM -0800, Junio C Hamano wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > From: "Kirill A. Shutemov" <kirill@shutemov.name>
> >
> > --strip::
> > 	Remove from tag message lines staring with '#', trailing spaces
> > 	from every line and empty lines from the beginning and end.
> > 	Enabled by default. Use --no-strip to overwrite the behaviour.
> >
> > --no-strip is useful if you want to take a tag message as-is, without
> > any stripping.
> 
> That is not a commit log message ;-)

Ok, I'll fix.

> > Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> 
> > diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> > index c83cb13..dbb76a6 100644
> > --- a/Documentation/git-tag.txt
> > +++ b/Documentation/git-tag.txt
> > @@ -99,6 +99,11 @@ OPTIONS
> >  	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
> >  	is given.
> >  
> > +--strip::
> > +	Remove from tag message lines staring with '#', trailing spaces
> > +	from every line and empty lines from the beginning and end.
> > +	Enabled by default. Use --no-strip to overwrite the behaviour.
> 
> s/overwrite/override/; or replace the last sentence with "With
> `--no-strip`, the tag message given by the user is used as-is".

Ok.

> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index 9b6fd95..05a1fd4 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > ...
> > @@ -356,7 +362,7 @@ static void create_tag(const unsigned char *object, const char *tag,
> >  
> >  		if (!is_null_sha1(prev))
> >  			write_tag_body(fd, prev);
> > -		else
> > +		else if (opt->strip)
> >  			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
> 
> Why are you not writing template when no strip is done? (Not an objection
> disguised as a rhetorical question, but a question).
> 
> The user who typed "tag -a v1.2.3 HEAD" that spawns an editor would still
> find it useful to have commented instructions, once we start filling the
> template with more useful information that is customized for the
> situation (e.g. "git show -s --oneline" output), no?

Yes. But in this case commented instructions will not be stripped and they
will go to the message. I think user will be confused.

We can show show some instructions before spawning the editor. What do
you think?

> > @@ -423,8 +430,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >  	const char *object_ref, *tag;
> >  	struct ref_lock *lock;
> >  
> > -	int annotate = 0, sign = 0, force = 0, lines = -1,
> > -		list = 0, delete = 0, verify = 0;
> > +	struct create_tag_options opt = {
> > +		.sign = 0,
> > +		.strip = 1,
> > +	};
> 
> Avoid doing this.  Even though these C99 initializers are nicer and more
> readable way to write this, we try to be gentle to people with older
> compilers that do not grok the syntax.

It's sad. Do you have a list of compilers which are important for the
project?

> Except for the above minor nits, the patch basically looks good. Please
> hold onto it and resubmit after 1.7.8 final ships.

Thanks.

-- 
 Kirill A. Shutemov
