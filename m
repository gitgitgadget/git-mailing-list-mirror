From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 08 May 2006 22:31:05 -0700
Message-ID: <7vslnj933a.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081828250.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 07:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdKoZ-00011G-5x
	for gcvg-git@gmane.org; Tue, 09 May 2006 07:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWEIFbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 01:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWEIFbN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 01:31:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43958 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751001AbWEIFbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 01:31:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509053111.VTQQ17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 01:31:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605081828250.3718@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 May 2006 18:30:55 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19817>

Linus Torvalds <torvalds@osdl.org> writes:

>> 	[branch]
>>         	name = linus
>>         	url = git://git.kernel.org/../torvalds/linux-2.6
>> 
>> 	[branch]
>>         	url = git://git.kernel.org/../jgarzik/libata-dev
>>         	name = libata
>
> Yes, that would be a silent and confusing error.

Although I haved raised objections, I actually started to like
the idea of using multiple [branch] (or wasn't it [remote] given
the example variables we have been using?) sections.

We should first depart from the Windoze .INI mindset.  While I
do not think users expect case insensisitivity, only because the
section headers are marked with [brackets], if that syntax
somehow makes people expect such, maybe we should stop using
[bracket] as section markers.

Whatever marker we end up using, I'd suggest somewhat different
approach.

 - Treat each part that are grouped under [bracketted-string]
   marker as a bag of variable=value pairs.  Loosely speaking,
   the bracketted-string defines a schema -- what kind of
   variables are expected to be there in that seciton.  For
   example, a section for things we traditionally had in remotes
   file would contain fields (variables) such as url, fetch, and
   push (we might add proxy to this list).  And we call this
   "bag of variable=value" a section.

 - There can be multiple sections in a config file that uses the
   same schema.  The example at the beginning of this message
   is perfectly valid.  It defines two sections of type
   [branch], each of which has two variables (name and url) in
   it.

Unlike your earlier suggestion, the second [branch] is not just
for readability; it is mandatory, because we are talking about
two different [branch]es (eh, that's [remote]s, really), it
needs to be there to separate two instances.

The above would break the existing repo-config command, but
let's forget about it for now.  I think we are breaking
forward/backward compatibility in any proposals brought up so
far anyway.

We would need user interface level commands to

	add a new section
        delete a section

We would need a way to identify a secion, perhaps using a value
of arbitrary key (e.g. "where name=blah").  Creating a section
could be implicit, just like the current repo-config.

        add a variable=value to a section
        delete a variable=value from a section
	retrieve variables' values from a section
	list value of a variable from all sections of a kind.

Probably need to support the same variable name appearing more
than once, just like the current multi-value support.

The current multi-value stuff assumes that multi-values are
exceptions, and rare.  While I do not necessarily agree with
that, for now let's assume that is true.

Creating a new section with given variables:

	$ cfg --set section var value var value ...
   (eg) $ cfg --set branch name master merge origin pull linus

    Here, 'var' and 'value' are case sensitive; if they have
    syntactical metacharacters (WS, =, quotes, etc), they need
    to be quoted when cfg command writes to the file (i.e. the
    user do not have to quote more than necessary to protect
    them from the shell).

Updating an existing section's variables, or create a new one:

	$ cfg --replace section.var value where var0 = val0
   (eg) $ cfg --replace remote.url git://... where name = linus

    Look for a "remote" section that has a variable "name" with
    value "linus" in it, and replace its "url" variable with
    "git://...".  If there is no "remote" section with such a
    name, create it.  For the key matching syntax, I do not
    insist on using "where" (I merely used it for continuity
    from the previous discussion).  For the comparison operator,
    in addition to the '=' shown above, we would probably want
    to have regexp match (perhaps ':' to emulate "expr") as well.

Retrieving a variable:

	$ cfg --get section.var [where var0 = val0]
   (eg) $ cfg --get remote.url where name = linus

List sections:

	$ cfg --list section.var
   (eg) $ cfg --list remote.name

So, an equivalent of "grep -H URL: .git/remotes/*" becomes something like:

	for name in `cfg --list remote.name`
        do
             	url=`cfg --get remote.url where name = "$name"`
                echo "$name: URL: $url"
	done
