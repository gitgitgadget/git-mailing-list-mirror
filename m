From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 03/21] Refactoring to make verify_tag() and
 parse_tag_buffer() more similar
Date: Sat, 09 Jun 2007 12:49:44 +0200
Message-ID: <200706091249.45042.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090213.40785.johan@herland.net>
 <Pine.LNX.4.64.0706090339280.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 09 12:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwyWS-0003Pa-16
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 12:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbXFIKuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 06:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXFIKuE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 06:50:04 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44578 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbXFIKuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 06:50:01 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00C0B7FB3G00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 12:49:59 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00A487EXXCA0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 12:49:45 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD008B77EX4V30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 12:49:45 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706090339280.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49567>

On Saturday 09 June 2007, Johannes Schindelin wrote:
> Hi,

Hi. Thanks for taking the time to look at (some of) my patch. Most of your
questions below can be answered with a single answer:

The main purpose of the patch is (as the subject line says) to bring the
two functions more in line with eachother. At the time I made the patch,
I had made the observation that these function were trying to do much the
same thing, albeit in a slightly different form. This patch is therefore
about applying a series of (mostly non-functional) refactorings to make
their diff as small as possible. This involves "stupid" changes such as
renaming variables, tweaking whitespace, reordering the declaration of
variables, etc. It's all to make the functions similar to the point where
I can diff them, get a small and meaningful result, see the remaining
_real_ differences, and in the end, _merge_ them (see patches 7-9).
If this whole exercise didn't end up with merging the two functions into
one, I would _totally_ agree with you that all this refactoring is more
harmful than beneficial.

> On Sat, 9 Jun 2007, Johan Herland wrote:
> >  	if (size < 64)
> >  		return error("wanna fool me ? you obviously got the size wrong !");
> >  
> > -	buffer[size] = 0;
> 
> Are you sure that your buffer is always NUL terminated?

First, (and you'll see this in the commit message) I'm _moving_ (not
removing) the NUL termination out of verify_tag() and into main() (which I
can be sure is the only caller of verify_tag(), since verify_tag is
declared static, and there is no other call in that file). Two reasons for
doing this:

1. Make verify_tag more similar to parse_tag_buffer() (because
parse_tag_buffer() does not NUL terminate)

2. Do the NUL termination as close to the code that actually populated the
buffer with data (the read_pipe() in main())


So now you can ask: Why doesn't parse_tag_buffer() NUL terminate its
input? It _that_ safe? And I ran around checking all the callers of
parse_tag_buffer, and found that all of them use data (most of which
originates from read_sha1_file()) that's already NUL terminated.

In the end, I also put in a comment on the resulting function
(parse_and_verify_tag_buffer()), explicitly saying the given data _must_
be NUL terminated.



Side note: At first I actually thought the manual NUL termination
could cause a buffer overflow (i.e. if the given size was the same as the
allocated size), so I actually have a version of all of this where I
_don't_ assume the buffer is NUL-terminated at all, and put in lots of
bounds checking, replace strchr() with memchr(), etc.

I then took a hard look at read_pipe(), and discovered that if you
use it to fill a 4096-byte buffer with 4096 bytes of data, it actually
_will_ reallocate to 8192 bytes and leave room for the NUL termination
(and much more) (I believe this should have been documented in read_pipe).
Thus the NUL termination was safe all along.


> > -	type_line = object + 48;
> > +	type_line = data + 48;
> 
> Quite a lot of changes seem to do this object->data. The patch would have 
> been much more compact if you just had renamed buffer to object instead of 
> data.

Yes, but it would have made the aforementioned diff to parse_tag_buffer()
larger.

> >  	/* TODO: check for committer info + blank line? */
> >  	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
> >  
> >  	/* The actual stuff afterwards we don't care about.. */
> >  	return 0;
> > -}
> >  
> >  #undef PD_FMT
> > +}
> 
> Any particular reason for this?

Well, PD_FMT is only used inside the function, so I found it easier to
move the #definition of PD_FMT inside the function to indicate the scope
(_perceived_ scope; I know it hasn't any effect on the compiled code).
But since the whole function is going away in a few patches anyway,
I should have probably left it out of this patch entirely.

> > @@ -124,6 +120,7 @@ int main(int argc, char **argv)
> >  		free(buffer);
> >  		die("could not read from stdin");
> >  	}
> > +	buffer[size] = 0;
> 
> Ah, so you terminate the buffer here. From the patch, it is relatively 
> hard to see if this line is always hit _before_ the function is called 
> that evidently relies on NUL termination. By moving it here, I think it is 
> much more likely to overlook the fact that the function, which made sure 
> that its assumption was met, needs this line. Whereas if you left it where 
> it was, the assumption would always be met.

But if I leave the NUL termination within the function I would have to
backtrack out of the function to all of its potential callers and check
whether it's safe to write to index size. Since the word "size" could
easily mean "allocated size" I would have the initial feeling that this
might be a buffer overflow, i.e. _not_ safe.

In the end, I think the best solution is to make sure NUL termination
happens before calling the function, and then documenting explicitly
that the function assumes NUL terminated input. Which is exactly what
I end up with at the end of the patch series.

> > -	sig_line++;
> > +	tagger_line++;
> 
> I am really reluctant with renamings like these. IMHO they don't buy you 
> much, except for possible confusion. It is evident that sig means the 
> signer (and it is obvious in the case of an unsigned tag, who is meant, 
> too).

Hmm. The "type" line is found in the variable type_line, the "tag" line is
found in the variable tag_line, and the "tagger" line is found in the
variable ... sig_line? Nope, I don't buy it.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
