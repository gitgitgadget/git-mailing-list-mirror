From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [RFC] Configuring (future) committags support in gitweb, especially
 bug linking
Date: Tue, 17 Feb 2009 07:32:01 -0800
Message-ID: <499AD871.8000808@oak.homeunix.org>
References: <200811082007.55045.jnareb@gmail.com> <200811082102.44919.fg@one2team.net> <200811082335.49505.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fg@one2team.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRxX-0007RP-0L
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZBQPcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 10:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbZBQPcO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:32:14 -0500
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:32650 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751306AbZBQPcM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 10:32:12 -0500
Received: (qmail 60805 invoked from network); 17 Feb 2009 15:32:11 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp122.sbc.mail.sp1.yahoo.com with SMTP; 17 Feb 2009 15:32:10 -0000
X-YMail-OSG: SKpbv_gVM1kPCe33dhxjFz_6IraAxQUWppr0SeSgdlHrJpYEoCy5defkJl0t.DHQ6zuZVPmlcTKlJnzYnfEUkVQ2RZPbiwMOxK0.CDt3P_uoX_7x7c4RusN5h_2EgVPl6lv22dp_ldO.tfQm6HmjfhLroIDYvXVEjFzP7fwn_NoGNKVW4ml3UhgSevwy
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LZRvd-0000cR-3d; Tue, 17 Feb 2009 07:32:09 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <200811082335.49505.jnareb@gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110401>

I'm interested in cross-linking bug references in commit messages to a
bug tracking system.  I started tinkering a couple weeks ago and am
finally understanding that committags encompass this functionality.
(From the subject line I first understood "tags" to mean git tags rathe=
r
than commit message munging.)

Is the committags idea still under active development?

I'd be happy to share what I have, which is for bug linking only, but
very little code would apply to the more general concept of committags.
 Here are some ideas that might apply...


Two regexes would make it easier to configure a driver without needing
look-ahead and look-behind assertions.  For example, if you want to
match non-negative integers but only in the context of a Resolves-bug
header:

    Resolves-bug: 1234, 1235

With two regexes you can write:

    /^Resolves-bug: \d+(, \d+)*/
    /\d+/

But with only one, you'd have to write:

    /(?<=3D^Resolves-bug: (\d+, )*)(\d+)/

The need for a lookbehind assertion means I need to stop at perlreref t=
o
lookup syntax.  Hrm... and with testing I see that it's worse than that=
:

    $ perl -wpe 's/(?<=3D^Resolves-bug: (\d+, )*)(\d+)/[$2]/g'
    Variable length lookbehind not implemented in regex; marked by <--
    HERE in m/(?<=3D^Resolves-bug: (\d+, )*)(\d+) <-- HERE / at -e line=
 1.

I guess it can't be done even with the look-behind assertion.


I got the two-regex idea from a spec I ran across while evaluating
Subversion:

http://guest:@tortoisesvn.tigris.org/svn/tortoisesvn/trunk/doc/issuetra=
ckers.txt

If there is interest in BTS integration beyond gitweb, for example in
git-gui, gitk, or the Windows UIs, then perhaps this spec would be wort=
h
considering.  It covers more than just hyperlinking.  It also considers
issues like how to draw the form field for a bug ID as part of a commit
message form, how to validate that form field, and then how to munge th=
e
log message to include the entered ID.  Some details, like using a
newline to separate the two regexes, might be more awkward for Git than
Subversion.


I like the idea of allowing a regex writer -- a gitweb admin or a
repository owner -- to ignore issues regarding HTML escaping.  For
example, I'd rather not have &nbsp; in the regex.  And I don't want the
replacement to have to escape "&" in a query string.  That's a strength
of not having to write the whole link replacement rule.  And I think
hyperlinking will be one of the most common uses of this committag
feature, so it's worth special support.

In the case of false positives, it might also be helpful to have a titl=
e
attribute that explains the committag's interpretation of the text.

I also like the idea of giving the admin full control to specify a Perl
function of some sort, which might go as far as looking up bug summarie=
s
for the "title" attribute or adding JS to fetch it via AJAX on
mouse-over.  But I doubt I would bother with that myself.


Appealing as it is, the use of '$1' in my replacements didn't work for =
me:

    $ perl -wpe '$reg =3D "(\\d+)"; $rep =3D ".\$1."; s/$reg/$rep/g'
    123
    .$1.

I think usage of capturing parenthesis is important, even with two
regexes, because it makes it easier to specify link text that's broader
than the data that goes in the URL.  Specifically, I wanted to be able
to produce HTML like this, with the hash mark hyperlinked but not used
in the URL:

    <a href=3D"...bug=3D123">#123</a>

I guess that's just my aesthetic.  To support that, my code calls
sprintf with $&, $1, $2, ... $9, and that particualr replacement URL
uses %2$s.


I'm concerned about the composition of these committag drivers.  In
other words, will it be hard for the configurer to manage interactions
between committag drivers?  To choose a sane order, will I have to
understand the implementation details of each committag driver?

Perhaps a simpler alternative would be to let at most one driver proces=
s
a given snippet of text, forbidding nesting of replacements.  (If I
understand Junio's suggestion to use a list of strings and refs,
non-nesting overlaps are already not supported.)  If all replacements
were hyperlinks -- and I expect that to be the common case -- they
wouldn't be nestable anyway.  I wouldn't see it as a huge loss for the
nesting examples I can think of:  Separate rules for span around S-o-b
and linking or obfuscation of email could be combined into one...  A
rule to shade text quoted email-style with leading angle brackets could
just clobber any further processing of that text.  And it might simplif=
y
the code and testing of it quite a bit.

If committags do turn out to support nesting, perhaps it would make
sense to stratify the ordering so that it's clear whether a particular
driver takes as input HTML vs. text and outputs HTML vs. text.  (For
example, weak email obfuscation might be text -> text.)  I guess to
strictly honor the input and output types of a driver, the text -> html
drivers still have to be expanded in a single pass.


A few ideas for drivers that I don't think have been mentioned yet:

* Wiki page names, like to [[Feature Documentation]].  These are notabl=
e
because they tend to contain punctuation that get HTML-escaped, like
quotes and ampersands.

* Links to gitweb itself, such as 123abc:file.txt and HEAD:file.txt.  I
guess the current hash linking sort of does the first case except that
you have to get the hash of the blob instead of using the commit hash,
and the current hash linking wouldn't reveal the filename until after
you click, nor when viewing textual log messages.  I'm not sure whether
special support for linking to multi-commit diffs or other object types
would be as helpful.

Marcel


Jakub Narebski wrote:
> Dnia sobota 8. listopada 2008 21:02, Francis Galiegue napisa=B3:
>> Le Saturday 08 November 2008 20:07:53 Jakub Narebski, vous avez =E9c=
rit :
>>> Francis Galiegue <fg@one2team.net> writes
>>> in "Need help for migration from CVS to git in one go..."
>>>
>>>> * third: also Bonsai-related; Bonsai can link to Bugzilla by
>>>> matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
>>>> http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb h=
ave
>>>> this built-in? (haven't looked yet) Is this planned, or has it bee=
n
>>>> discussed and been considered not worth the hassle?
> [...]
>
>>> Committags are "tags" in commit messages, expanded when rendering c=
ommit
>>> message, like gitweb now does for (shortened) SHA-1, converting the=
m to
>>> 'object' view link.  It should be done in a way to make it easy
>>> configurable, preferably having to configure only variable part, an=
d not
>>> having to write whole replacement rule.
>>>
>>> Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
>>> Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protectin=
g
>>> of email addresses, "rich text formatting" like *bold* and _underli=
ne_,
>>> syntax highlighting of signoff lines.
>>>
>> What do you mean with "not having to write whole replacement rule"?
>
> Like in example with 'link' rule, not having to write whole
> <a href=3D"http://example.com/bugzilla.php?id=3D$1">$&</a>
> (or something like that).
>
>>> I think it would be good idea to use repository config file for
>>> setting-up repository-specific committags, and use whatever Perl
>>> structure for global configuration. The config language can be
>>> borrowed from "drivers" in gitattributes (`diff' and `merge' driver=
s).
>>>
>>> So the example configuration could look like this:
>>>
>>>   [gitweb]
>>>      committags =3D sha1 signoff bugzilla
>>>
>>>   [committag "bugzilla"]
>>>      match =3D "\\b(?:#?)(\\d+)\\b"
>>>      link  =3D "http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1=
"
>>>
>>> where 'sha1' and 'signoff' are built-in committags, committags are
>>> applied in the order they are put in gitweb.committags;
>> I don't understand what the "signoff" builtin is : is that a link to=
 see only
>> commits "Signed-off-by:" a particular person?
>
> Committags doesn't need to be replaced by links. In this case I meant
> here using 'signoff' class for Signed-off-by: (and the like) lines, b=
y
> wrapping it in '<span class=3D"signoff">' ... '</a>'.
>
>> And also, what about the sha1 builtin? AFAIK, a SHA1 can point to a =
commit, a
>> tree, and others... In fact, it points to any of these right now, bu=
t how
>> would you tell apart these different SHA1s in a commit message? The =
only
>> obvious use I see for it is the builtin "Revert ..." commit message,=
 that the
>> commiter _can_ override...
>
> SHA1 (or shortened SHA1 from 8 charasters to 40 characters, or to be
> even more exact something that looks like SHA1) is replaced by link
> to 'object' view, which in turn finds type of object and _redirect_
> to proper view, be it 'commit' (most frequent), 'tag', 'blob' or 'tre=
e'.
>
> We could have used instead gitweb link with 'h' (hash) parameter, but
> without 'a' (action) parameter, which currently finds type of object
> and _uses_ correct view...
>
>> Finally, is there any reason to think that a sha1 or signoff committ=
ag will
>> ever need to be overriden in some way?
>
> One might not want to link SHA1, for example if there are lots of fal=
se
> positives because of commit message conventions or something, or refi=
ne
> 'signoff' committag to use different styles for different types of
> signoff: Signed-off-by, Acked-by, Tested-by, other.  Having explicit
> 'signoff' committag allows us also to put some committags _after_ it,
> for example SPAM-protection of emails, or add some committag before
> 'sha1' to filter out some SHA1 match false positives.
>
>>> possible actions
>>> for committag driver include:
>>>  * link: replace $match by '_<a href=3D"$link">_$match_</a>_'
>>>  * html: replace $match by '_$html_'
>>>  * text: replace $match by '$text'
>>> where '_a_' means that 'a' is treated as HTML, and is not expanded
>>> further, and 'b' means that it can be further expanded by later
>>> committags, and finally is HTML-escaped (esc_html).
>>>
>> What use do you see for the html match? Just asking...
>
> For example 'signoff' committag... well, it is not exactly pure "html=
"
> but rather something like template.
>
>   [committag "signoff"]
>         match =3D "(?i)^ *(signed[ \\-]off[ \\-]by[ :]|acked[ \\-]by[=
 :]|cc[ :])"
>         templ =3D "{<span class=3D\"signoff\">}$1{</span>}"
>
> Or simpler
>
>   [committag "signoff"]
>         match =3D "(?i)^ *(signed[ \\-]off[ \\-]by[ :]|acked[ \\-]by[=
 :]|cc[ :])"
>         class =3D signoff
>
>> And I don't see what you '_a_' and '_b_' are about...
>
> For example in link match, the text of the link can be further refine=
d
> by committags later in sequence.
>
> --
> Jakub Narebski
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
