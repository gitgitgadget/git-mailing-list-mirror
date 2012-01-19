From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Thu, 19 Jan 2012 16:53:16 +0100
Message-ID: <87bopzofir.fsf@thomas.inf.ethz.ch>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
	<87lipexawp.fsf@thomas.inf.ethz.ch>
	<CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
	<87ipkhqnr8.fsf@thomas.inf.ethz.ch>
	<CALUzUxqXTXZv4RE=4rBa79T3_1y7UdqZ6okjC1y-Ve+=NDbQ2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnuIn-0008VR-3G
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 16:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310Ab2ASPxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 10:53:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15017 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab2ASPxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 10:53:19 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 16:53:16 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 16:53:16 +0100
In-Reply-To: <CALUzUxqXTXZv4RE=4rBa79T3_1y7UdqZ6okjC1y-Ve+=NDbQ2g@mail.gmail.com>
	(Tay Ray Chuan's message of "Wed, 18 Jan 2012 15:32:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188817>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Thu, Jan 12, 2012 at 5:22 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> [snip]
>> Case in point, consider my patch sent out yesterday
>>
>>  http://article.gmane.org/gmane.comp.version-control.git/188391
>>
>> It consists of a one-hunk doc update.  word-diff is not brilliant:
>>
>>  -k::
>>          Usually the program [-'cleans up'-]{+removes email cruft from+} the Subject:
>>          header line to extract the title line for the commit log
>>          [-message,-]
>>  [-      among which (1) remove 'Re:' or 're:', (2) leading-]
>>  [-      whitespaces, (3) '[' up to ']', typically '[PATCH]', and-]
>>  [-      then prepends "[PATCH] ".-]{+message.+}  This [-flag forbids-]{+option prevents+} this munging, and is most
>>          useful when used to read back 'git format-patch -k' output.
>> [snip the rest as it's only {+}]
>>
>> But character-diff tries too hard to find common subsequences:
>>
>>  $ g show HEAD^^ --word-diff-regex='[^[:space:]]' | xsel
>>[snip]
>>  w-]{+.  T+}hi[-te-]s[-paces, (3) '[' up t-] o[-']', ty-]p[
>>
>> is just line noise?  The colors don't even help as most of it is removed
>> (red).
>
> You missed the '+' quantifier, as in
>
>   [^[:space:]]+

Did I?  I was working from the example you provided earlier

}   matrix[a,b,c]
}   matrix[d,b,c]
} gives
}   matrix[[-a-]{+d+},b,c]
} 
} and when we have
} 
}   ImagineALanguageLikeFoo
}   ImagineALanguageLikeBar
} we get
}   ImagineALanguageLike[-Foo-]{+Bar+}

Under [^[:space:]]+ neither of the examples would work.  Actually,
[^[:space:]]+ is the same as today's default, the [^[:space:]]* I
mentioned later is (strictly speaking) broken as it allows for a
0-length match.  (It doesn't really matter because IIRC the engine
ignores 0-length words.)

>> That being said, I can see some arguments for changing the default to
>> split punctuation into a separate word.  That is, whereas the current
>> default is semantically equivalent to a wordRegex of
>>
>>  [^[:space:]]*
>>
>> (but has a faster code path)
>
> Oh right, there *is* a sensible default implemented in. Somehow I was
> under the impression that there wasn't.
>
> I wonder which is faster, using the non-whitespace regex, or the
> isspace() calls...

I tried measuring it across a few commits, but it mostly gets drowned
out by the diff effort.  For a commit with stat

  exercises/cgal/cover/cover.cpp  |    5 +-
  exercises/cgal/cover/cover.in1  |27014 +++++++++++++++-----
  exercises/cgal/cover/cover.in2  |48996 +++++++++++++++++++++++------------
  exercises/cgal/cover/cover.in3  |55041 +++++++++++++++++++++++++--------------
  exercises/cgal/cover/cover.in4  |47600 ++++++++++++++++++++--------------
  exercises/cgal/cover/cover.int  |43491 ++++++++++++++++++++++---------
  exercises/cgal/cover/cover.out1 |   53 +-
  exercises/cgal/cover/cover.out2 |   24 +-
  exercises/cgal/cover/cover.out3 |   11 +-
  exercises/cgal/cover/cover.out4 |    2 +-
  exercises/cgal/cover/cover.outt |   23 +-
  exercises/cgal/cover/gen        |   39 +-
  exercises/cgal/cover/gen-1.cpp  |    4 +-
  exercises/cgal/cover/gen-2.cpp  |    6 +-
  exercises/cgal/cover/gen-3.cpp  |    6 +-

(sorry, can't share as those testcases are secret) I get best-of-5
timings

  --word-diff-regex='[^[:space:]]+'    0:07.50real 7.40user 0.07system
  --word-diff                          0:07.47real 7.41user 0.03system

In conclusion, "meh".  I think ripping out the isspace() part would make
for a nice code reduction.

>> and your proposal is equivalent to
>>
>>  [^[:space:]]|UTF_8_GUARD
>>
>> I think there is a case to be made for a default of
>>
>>  [^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+
>>
>> or some such.  There's a lot of bikeshedding lurking in the (non)extent
>> of the [[:alnum:]] here, however.
>
> Care to explain further? Not to sure what you mean here.

For natural language, it may or may not make sense to match numbers as
part of a word.

For typical use in e.g. emails, a lot of punctuation has a double role;
breaking words in

  http://article.gmane.org/gmane.comp.version-control.git/188391

may or may not make sense.

For some uses, especially source code, it would be better to match an
underscore _ as part of a complete word, too.

For some programming languages, say lisp, a dash - would also belong in
the same category.

There's no real reason other than ease of implementation why the pattern
handles ASCII non-alphanumerics separately, but non-ASCII UTF-8
non-alnums (like, say, unicode NO-BREAK SPACE which would show as \xc2
\xa0) always goes into a word.  But if you were to make UTF-8 sequences
a single word, text in (say) many European languages would become
chunked at accented letters.

I'm sure you can find more items for this list.  It's a grey area.


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
