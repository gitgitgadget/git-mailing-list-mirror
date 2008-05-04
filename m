From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sun, 4 May 2008 10:25:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041018280.30431@racer>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com> <1209736766-8029-1-git-send-email-pkufranky@gmail.com> <alpine.DEB.1.00.0805031501290.30431@racer> <7vmyn7uvut.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsaUK-0002Xu-Ob
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYEDJZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbYEDJZn
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:25:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:55879 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752715AbYEDJZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:25:42 -0400
Received: (qmail invoked by alias); 04 May 2008 09:25:40 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp053) with SMTP; 04 May 2008 11:25:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vEck1AxtvVZNfs5bMYieEfA6ekgTiRl9CMVUCkp
	6zg/fEgeLwxz4f
X-X-Sender: gene099@racer
In-Reply-To: <7vmyn7uvut.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81153>

Hi,

On Sat, 3 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, you can specify which characters are to be interpreted as word 
> > characters with "--color-words=A-Za-z", or by setting the config variable 
> > diff.wordCharacters.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	I would have preferred an approach like this.
> 
> Hmmm...

Just to clarify: specifying word characters, and allowing sets (as 
specifyable for tr(1)).

> > diff --git a/README b/README
> > index 548142c..0e325e2 100644
> > --- a/README
> > +++ b/README
> > @@ -4,7 +4,7 @@
> >  
> >  ////////////////////////////////////////////////////////////////
> >  
> > -"git" can mean anything, depending on your mood.
> > +"git" cann mean anything, depending on your mood.
> 
> Heh.

Yeah, I already said I am a moron.  I can repeat it if it makes you 
happier ;-)

> > @@ -456,7 +514,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
> >  	plus.ptr = xmalloc(plus.size);
> >  	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
> >  	for (i = 0; i < plus.size; i++)
> > -		if (isspace(plus.ptr[i]))
> > +		if (!word_character[(unsigned char)plus.ptr[i]])
> >  			plus.ptr[i] = '\n';
> >  	diff_words->plus.current = 0;
> 
> I do not think there is much difference between specifying the set of 
> word characters and the set of non-word characters, especially as long 
> as your definition of "character" is limited to 8-bit bytes.  By 
> enumerating word characters, your patch is letting the user specify non 
> word characters that are remainder from the 256-element set.  By the 
> way, I think you meant to do the same for the "minus" side a few lines 
> above this hunk.

I just imitated Ping's patch, but you're right, I forgot that.

> I commented on the patch from Ping earier about a quite different issue. 
> I was wondering if we can avoid losing the non-word character 
> information. The original code replaces any isspace byte with LF, but a 
> whitespace is a whitespace is a whitespace so there won't be much loss 
> of information, but making the above isspace() configurable means that 
> now you are going to drop non-space non-word characters from the output 
> set.
> 
> Instead of dropping the original character and replacing it with LF, I 
> thought a more sensible approach would be to _insert_ a line break 
> between runs of word characters and non-word characters (while probably 
> dropping a LF in the original).  That is, instead of what the current 
> implementation of the above loop does to "ab c d" (i.e. rewrite it to 
> "ab\n\nc\nd"), rewrite it to "ab\n \nc\n \nd".  Which feels more 
> consistent with the way how \b should work.

The conversion to "\n" is done only because of limitations in libxdiff 
(did I not just rant about artificial limitations in another mail?), 
because it is married to the notion that LF ends a line.

Now, there are two options:

- try to reconstruct the original text from what libxdiff returns.  This 
  is potentially memory-efficient, but tricky, and therefore easy to get 
  wrong.

- go with your approach.  You will have to duplicate all the text, so this 
  is something quite heavy on memory consumption.  But you have to do 
  something special for _real_ LFs so that they are not stripped away when 
  displaying the result.

I like your idea (I was trying to come up with something sensible for the 
first option, but as I said, it is too tricky).

But the LF issue is a real one.

Ciao,
Dscho
