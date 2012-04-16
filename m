From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Mon, 16 Apr 2012 22:35:23 +0100
Message-ID: <4F8C909B.7010507@pileofstuff.org>
References: <4F8AF306.8070804@pileofstuff.org> <7vipgztpaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJta9-0008Tb-MW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab2DPVf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:35:29 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:55366 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179Ab2DPVf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 17:35:28 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120416213525.FPIL22007.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 16 Apr 2012 22:35:25 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120416213525.NGDJ3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 16 Apr 2012 22:35:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <7vipgztpaf.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=YmvJA8EKKy4A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=mV9VRH-2AAAA:8 a=tORimNnkjjAw3DpGjfEA:9 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195698>

On 16/04/12 21:06, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
>>  
>> +Unlike Subversion, 'svn-fe' interprets property key/value pairs as
>> +null-terminated binary strings.  This means it will accept content
>> +that Subversion normally wouldn't produce (such as filenames
>> +containing tab characters) or would refuse to parse (such as usernames
>> +containing Latin-1 characters).  However, like Subversion it will
>> +handle newlines incorrectly in filenames (see BUGS below).
>> +
> 
> Do the first two sentences in the above paragraph claim that it a bug that
> 'svn-fe' does not mimick what Subversion does?  I am not sure what lessons
> the authors of tools, whose output is meant to feed svn-fe, are expected
> to learn here.  For example, is the purpose of the above paragraph to make
> tool authors realize that "NUL terminates key and value, so I have to
> refrain from using a key or a value that contains a NUL byte?" [*1*]  Even
> in that case, it is unclear to me what I (as an author of such a tool that
> reads data from somewhere and format it to plesae svn-fe) could do with
> that knowledge.
> 
> [Footnote]
> 
> *1* By the way, NULL is a pointer that does not point anywhere.  The name
> of a byte whose value is 0x00 is NUL.

The dumpfile documentation says that "... property key/value pairs may
be interpreted as binary data in any encoding by client tools"[1], but
SVN itself interprets the data as UTF-8, so I was surprised to see
svn-fe hadn't aped that behaviour.  You could argue this is a bug if you
want to call `svnadmin` the reference implementation.  You could even
argue that treating NUL characters specially is a bug if you want to
call the documentation the official standard (albeit a bug shared by
`svnadmin`).  Personally I don't have a problem with either decision, so
I've just noted some unobvious behaviour.

Lessons to learn will depend on the author, but here are some I took:

1. UTF-8 is the most common encoding, but not the only one.  If your
tool only allows UTF-8 input and only produces only UTF-8 output then
you are the limiting factor in your toolchain.  In my case I think I'll
just live with that, but I would like to have known before I started.

2. `svn` itself isn't universally considered the reference
implementation, only a popular one.  When deciding the correct behaviour
(or the range of possible behaviours), it's not enough just to look at
what `svn` does.

3. `svn-fe` doesn't slavishly follow either the documentation or `svn`.
 Beyond a certain point you have to actually check assumptions against
svn-fe's behaviour (then document what you find so the next guy doesn't
have to ;).  Again, I think this is pragmatic but I would like to have
known earlier.

I've tried not to labour the above points, because it would be easy to
overstate them and because other authors will take different lessons.
It's certainly possible that some author would come to svn-fe wanting to
do something crazy like encode newlines as NULs and come away realising
C doesn't like that.  A more concrete example is that a GSoC student who
turns up next year to work on writing commits back to SVN will need to
know svn-fe chose not to care about UTF-8 and that there's a nest of
edge cases waiting for them.

	- Andrew

[1]http://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
