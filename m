From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 20:29:14 -0700
Organization: Twitter
Message-ID: <1430450954.22711.69.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	 <1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	 <20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	 <20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	 <20150430033725.GB12361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 05:29:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo1di-0003zo-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 05:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbbEAD3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 23:29:18 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33361 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbEAD3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 23:29:18 -0400
Received: by pdbnk13 with SMTP id nk13so80410786pdb.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 20:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=gRSf7izjhmYvlkG89xx+5cDYQpyx3PxMSLIpnlnkQLQ=;
        b=HXedKbQPPcjIPmG1RyijTRLhIbWOza7IiZfSkCkSy/Vi3zaHkGc06xjAdPtrrjd4Mw
         MsOe3VmOzHNGxBAcW2wwE9l+axbiS3WmzuHYXnWj8RVd02AzlV8cETHOyLWZgMytJGMn
         IW7OuJTNSJrXYhlJ3mZPqmbv2gKQQHHIe2VrARrI+wQmEKdOnycigxJqYCJlvJP1QbZ8
         Vib9zXktb3QpBF0C/0Yd5hzCjfUC7l3XqtxhvK0Z+snqB1ISSd6Vlb/mtTTeMhoOppDo
         Jnas+G4NLdBZVWRrNGp3HatbPKI/yTYRhRnni13oJrmTGfG2QwRBEQKqICy4JkSWeLqg
         8qjg==
X-Gm-Message-State: ALoCoQly/ZMBzEkzlrNENNCUjZs4rcPtDHGopmyVvubPoLA0LYMBlTwrwaIkX9TSozk3ndBzOOcx
X-Received: by 10.68.209.193 with SMTP id mo1mr13841413pbc.142.1430450957430;
        Thu, 30 Apr 2015 20:29:17 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id lb1sm3504632pab.39.2015.04.30.20.29.15
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 20:29:16 -0700 (PDT)
In-Reply-To: <20150430033725.GB12361@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268109>

On Wed, 2015-04-29 at 23:37 -0400, Jeff King wrote:
> On Wed, Apr 29, 2015 at 06:45:45PM -0700, David Turner wrote:
> 
> > On Wed, 2015-04-29 at 21:16 -0400, Jeff King wrote:
> > > On Wed, Apr 29, 2015 at 06:06:23PM -0700, David Turner wrote:
> > >   3. Ditto for out-of-tree. Note that this would be the _raw_ symlink
> > >      contents, not any kind of simplification (so if you asked for
> > >      "foo/bar/baz" and it was "../../../../out", you would the full path
> > >      with all those dots, not a simplified "../out", which I think is
> > >      what you were trying to show in earlier examples).
> > 
> > Unfortunately, we need the simplified version, because we otherwise
> > don't know what the ..s are relative to in the case of a link to a link:
> > 
> >   echo content >dest ;# actual blob
> >   mkdir -p foo/bar
> >   ln -s foo/bar/baz fleem             # in-tree link-to-link 
> >   ln -s ../../../external foo/bar/baz # out-of-tree link
> > 
> > If echo HEAD^{resolve}:fleem were to return ../../../external (after
> > following the first symlink to the second), we would have lost
> > information.
> 
> Urgh, yeah, thanks for the counter-example.
> 
> Here are some possible alternatives:
> 
>   1. If we can't resolve fully, don't resolve anything. I.e., return the
>      "fleem" object here, and the caller can recurse if they want. This is
>      simple and correct, but not as helpful to somebody who wants to follow
>      the out-of-tree link (they have to re-traverse the fleem->foo/bar/baz
>      link themselves).
> 
>   2. Consider it can error if resolution fails. If you ask for
>      "HEAD^{tree}^{commit}", that does not resolve to anything (because
>      we can't peel the tree to a commit). Like (1), this is simple and
>      correct, but probably not all that helpful. The caller has to
>      start from scratch and resolve themselves, rather than getting an
>      intermediate result.
> 
>   3. Return an object with the symlink relative to the original
>      filename (so "../external" in this case). This is kind of weird,
>      though, because we're not just returning a string from the name
>      resolution. It's an actual object.  So we'd be generating a fake
>      object that doesn't actually exist in the object db and
>      returning that. Feeding that sha1 to another program would fail.
> 
>   4. Return the last object we could resolve, as I described. So
>      foo/bar/baz (with "../../../external" as its content) in this case.
>      When you resolve a name, you can ask for the context we discovered
>      along the way by traversing the tree. The mode is one example we've
>      already discussed, but the path name is another. So something like:
> 
>        echo "HEAD^{resolve}:fleem" |
>        git cat-file --batch="%(objectname) %(size) %(intreepath)"
> 
>      would show:
> 
>        1234abcd 17 foo/bar/baz
>        ../../../external
> 
>      And then the caller knows that the path is not relative to the
>      original "fleem", but rather to "foo/bar/baz".
> 
>      The problem is that although this context lookup is already part of
>      get_sha1_with_context, that is not exposed through every interface.
>      E.g., "git rev-parse HEAD^{resolve}:fleem" will give you an object,
>      but you have no way of knowing the context.
> 
> I can't say that I'm excited about any of them. Perhaps you or somebody
> else can think of a more clever solution.
> 
> Note that the complication with (3) does come from my trying to push
> this down into the name-resolution code.

Actually, I think 4 has an insurmountable problem.  Here's the case I'm
thinking of:

ln -s ..  morx

Imagine that we go to look up 'morx/fleem'.  Now morx is the "last
object we could resolve", but we don't know how much of our input has
been consumed at this point.  So consumers don't know that after they
exit the repo, they still need to find fleem next to it.
