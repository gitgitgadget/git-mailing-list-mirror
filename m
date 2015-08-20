From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Thu, 20 Aug 2015 09:47:48 -0700
Message-ID: <xmqqvbc97vpn.fsf@gitster.dls.corp.google.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
	<vpqa8tn2sgy.fsf@anie.imag.fr>
	<CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
	<CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
	<vpq7foq1kpe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 18:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZST0M-0002iW-P1
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 18:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbHTQrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 12:47:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35222 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbHTQru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 12:47:50 -0400
Received: by pacdd16 with SMTP id dd16so23535837pac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/KKBPGDbPe57gJfh9W+78zFnaa5XxAoPnmE0bX+IVCs=;
        b=Rr7zwcPvpsm7Pl8glQZ2ZWF050reww2GUE1hDwwJ9UA0ndBc2F8MaqSPg5wjiHismS
         oxpTeM2cgpJe2vUdSXriYxFGuo7g5ppBh7lK9Rena50xo4hmEHZCq8bTkAwrn6v3YWW5
         0/kbGBcHduf7wjPfEzqNOI1qISLlBYI6Za6rCK6eZxqnok8sfbSyBGlxtv+1uS6wm4Xs
         5q8htf/SH/UTHu7RH/vNR54QsYTrlBuIOw/PI4wIyjn5QEYTN3JTCj6LOzVgLrg2NhhE
         bs4GClRe1YqMr67boI5r38EYOszhU9PvAemg3/xaNPJ64us0zFINa9VgE5orXLox8cEE
         AMhA==
X-Received: by 10.66.248.72 with SMTP id yk8mr6974390pac.112.1440089270210;
        Thu, 20 Aug 2015 09:47:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id hv3sm4898088pbb.83.2015.08.20.09.47.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 09:47:49 -0700 (PDT)
In-Reply-To: <vpq7foq1kpe.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	20 Aug 2015 09:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276251>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Speaking of quote_value, The quote doesn't work well with color's
>> for e.g.
>> git for-each-ref --shell --format="%(color:green)%(refname)"
>> '''refs/heads/allow-unknown-type'''
>> Seems like an simple fix, probably after GSoC I'll do this :)
>
> Anyway, the %(color) is really meant to be displayed on-screen, and the
> quoting is really meant to feed the value to another program, so I can
> hardly imagine a use-case where you would want both.
>
> But the current behavior seems fine to me: the color escape sequence is
> quoted, which is good. For example, you can
>
> x=$(git for-each-ref --shell --format="nocolor%(color:green)%(refname)" | head -n 1)
> sh -c "echo $x"
>
> it will actually display "nocolor" without color, then a green refname.
> I'm not sure the quoting is really necessary, but it doesn't harm and it
> makes sense since the escape sequence contains a '[' which is a shell
> metacharacter.

The point of --shell/--tcl/... is so that you can have --format
safely write executable scripts in the specified language.  Your
format string might look like this:

        --format="short=%(refname:short) long=%(refname)"

and one entry in the output in "--shell" mode would expand to

        short='master' long='refs/heads/master'

that can be eval'ed as a script safely without having to worry about
expanded atom values having characters that have special meanings in
the target language.  Your "nocolor" example works the same way:

        --format="var=%(color:green)%(refname)" --shell

would scan 'var=', emit it as literal, see %(color:green) atom, show
it quoted, see %(refname), show it quoted, notice that color is not
terminated and pretend as if it saw %(color:reset) and show it
quoted, which would result in something like:

        var='ESC[32m''master''ESC[m'

Note that the example _knows_ that the quoting rule of the target
language, namely, two 'quoted' 'strings' next to each other are
simply concatenated.  When using a hypothetical target language
whose quoting rule is different, e.g. "type two single-quotes inside
a pair of single-quote to represent a literal single-quote", then
you would write something like this to produce a script in that
language:

        --format="
            var1=%(color:green);
            var2=%(refname);
            var=var1+var2;
        "

as your format string (and it will not be used with --shell).  And
the atom-quoting code that knows the language specific rules would
quote %(atom) properly.  Perhaps the language uses `' for its string
quoting, in which case one entry of the output might look like

	var1=`ESC[32m';
        var2=`refs/heads/master';
        var=var1+var2;

which would be in the valid syntax of that hypothetical language.

Maybe you have an atom %(headstar) that expands to an asterisk for
the currently checked out branch, in order to mimick 'git branch -l'.

Using that, you might use --shell --format to invent a shorter output
format that does not show the asterisk but indicates the current
branch only with color, like so:

        --format='
            if test -z %(headstar)
            then
                echo %(refname:short)
            else
                echo %(color:green)%(refname:short)%(color:reset)
            fi
        '

and you would want %(headstar)'s expansion to be '*' or ''.

If we introduce %(if:empty)%(then)%(else)%(end), the above may
become something like this, removing the need for --shell
altogether:

        %(if:empty)%(headstar)%(then
        )%(refname:short)%(else
        )%(color:green)%(refname:short)%(color:reset)%(end)

With the current implementation, it is likely that this needs to be
a single long line; we may want to extend parsing of atoms to allow
a LF+whitespace before the close parenthesis to make the string more
readable like the above example, but that is an unrelated tangent.

But you should still be able to use "--shell" this way, assigning
the whole thing to a variable:
    
        --format='
                line=%(if:empty)%(headstar)%(then
                )%(refname:short)%(else
                )%(color:green)%(refname:short)%(color:reset)%(end)
                echo "$line"
        '

So I think 'quote' should apply only to the top-level atoms in the
nested %(magic)...%(end) world.  Expand %(if:empty)...%(end) and
then apply the quoting rule specific to the target language to make
the result safe to use as the RHS of the target language.  None of
the atoms that appear internally (e.g. %(headstar) that is being
tested for emptyness) must NOT be quoted.

If you have %(align:40)%(atom) and string%(end), the same logic
applies.  %(atom) is not a top level item (it is inside %(align))
so you would expand "%(atom) and string" without quoting, measure
its display width, align to 40-cols and then if --shell or any
quoting is in effect, applyl that, so that the user can do:

	--format='
            right=%(align:40)%(refname)%(end)
            left=%(align:20,right)%(refname:short)%(end)
            echo "$left $right"
	'

one entry of the output from which would expand to

	right='refs/heads/master                       '
        left='              master'
        echo "$left $right"

because the rule is to quote the whole %(align)...%(end) construct
only once.
