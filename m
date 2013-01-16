From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 2/8 v3] git_remote_helpers: fix input when running
 under Python 3
Date: Wed, 16 Jan 2013 09:45:34 +0000
Message-ID: <20130116094418.GA9089@river>
References: <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
 <20130115215412.GX4574@serenity.lan>
 <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
 <20130115224049.GZ4574@serenity.lan>
 <20130116000316.GA26999@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 10:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvPZk-0004tl-M3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 10:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758980Ab3APJqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 04:46:05 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:38869 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758969Ab3APJqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 04:46:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7F58122B61;
	Wed, 16 Jan 2013 09:46:00 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EHv4fXJHh9a; Wed, 16 Jan 2013 09:45:59 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id F2B4C22B4B;
	Wed, 16 Jan 2013 09:45:58 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id ADCED161E551;
	Wed, 16 Jan 2013 09:45:58 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVyPLLsHfMVo; Wed, 16 Jan 2013 09:45:58 +0000 (GMT)
Received: from river (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 409B5161E4FB;
	Wed, 16 Jan 2013 09:45:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130116000316.GA26999@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213741>

On Tue, Jan 15, 2013 at 07:03:16PM -0500, Pete Wyckoff wrote:
> john@keeping.me.uk wrote on Tue, 15 Jan 2013 22:40 +0000:
>> This is what keeping the refs as byte strings looks like.
> 
> As John knows, it is not possible to interpret text from a byte
> string without talking about the character encoding.
> 
> Git is (largely) a C program and uses the character set defined
> in the C standard, which is a subset of ASCII.  But git does
> "math" on strings, like this snippet that takes something from
> argv[] and prepends "refs/heads/":
> 
>     strcpy(refname, "refs/heads/");
>     strcpy(refname + strlen("refs/heads/"), ret->name);
> 
> The result doesn't talk about what character set it is using,
> but because it combines a prefix from ASCII with its input,
> git makes the assumption that the input is ASCII-compatible.
> 
> If you feed a UTF-16 string in argv, e.g.
> 
>     $ echo master | iconv -f ascii -t utf16 | xargs git branch
>     xargs: Warning: a NUL character occurred in the input.  It cannot be passed through in the argument list.  Did you mean to use the --null option?
>     fatal: Not a valid object name: ''.
> 
> you get an error about NUL, and not the branch you hoped for.
> Git assumes that the input character set contains roughly ASCII
> in byte positions 0..127.
> 
> That's one small reason why the useful character encodings put
> ASCII in the 0..127 range, including utf-8, big5 and shift-jis.
> ASCII is indeed special due to its legacy, and both C and Python
> recognize this.
> 
>> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
>> @@ -18,13 +18,16 @@ class GitImporter(object):
>>  
>>      def get_refs(self, gitdir):
>>          """Returns a dictionary with refs.
>> +
>> +        Note that the keys in the returned dictionary are byte strings as
>> +        read from git.
>>          """
>>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
>> -        lines = check_output(args).strip().split('\n')
>> +        lines = check_output(args).strip().split('\n'.encode('utf-8'))
>>          refs = {}
>>          for line in lines:
>> -            value, name = line.split(' ')
>> -            name = name.strip('commit\t')
>> +            value, name = line.split(' '.encode('utf-8'))
>> +            name = name.strip('commit\t'.encode('utf-8'))
>>              refs[name] = value
>>          return refs
> 
> I'd suggest for this Python conundrum using byte-string literals, e.g.:
> 
>         lines = check_output(args).strip().split(b'\n')
> 	value, name = line.split(b' ')
> 	name = name.strip(b'commit\t')
> 
> Essentially identical to what you have, but avoids naming "utf-8" as
> the encoding.  It instead relies on Python's interpretation of
> ASCII characters in string context, which is exactly what C does.

The problem is that AFAICT the byte-string prefix is only available in
Python 2.7 and later (compare [1] and [2]).  I think we need this more
convoluted code if we want to keep supporting Python 2.6 (although
perhaps 'ascii' would be a better choice than 'utf-8').

[1] http://docs.python.org/2.6/reference/lexical_analysis.html#literals
[2] http://docs.python.org/2.7/reference/lexical_analysis.html#literals


John
