From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Tue, 05 Mar 2013 21:51:02 +0100
Message-ID: <51365AB6.2010602@web.de>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 21:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCypo-0001rR-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 21:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab3CEUvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 15:51:14 -0500
Received: from mout.web.de ([212.227.17.11]:49162 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757267Ab3CEUvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 15:51:14 -0500
Received: from [192.168.178.41] ([91.3.160.134]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lz3FM-1UqfAS0TAG-014PkJ; Tue, 05 Mar 2013 21:51:08
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7vboaxu23y.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Fl80/6wzTqn75UUS/f8hYtwi3tVJgXFiYEJdlmnhYtA
 BpcypQ2k9MeTbQhU42PSlE7pNb9ulfqyF5PGxehlB/Ac2380tJ
 iHFVDLz8F17b+0HEhoMOHANCw9ObsNdej/nvYIspyhFXW6+nIh
 twQ4F8N94WLMMqZ2DD8jnqKl2iD57e8BD+qlPJJG+gZSkxY/uG
 qWhCHdu5aodAkgghiQMhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217477>

Am 05.03.2013 19:34, schrieb Junio C Hamano:
> Eric Cousineau <eacousineau@gmail.com> writes:
> 
>> Would these be the correct behaviors of Heiko's implementation?
> 
> I do not think Heiko already has an implementation, but let's try to
> see how each example makes sense.
> 
>> git submodule foreach # Empty command, pre-order
>> git submodule foreach --pre-order # Same behavior
>> git submodule foreach --post-order # Empty command, post-order
> 
> OK.  The last one shows "I am here" output differently from the
> other two, but otherwise they are all no-op.
> 
>> git submodule foreach 'frotz' # Do 'frotz' pre-order in each submodule
> 
> OK.  And it would be the same if you said either one of:
> 
> 	git submodule foreach --pre-order 'frotz'
> 	git submodule foreach --pre-order='frotz'
> 
>> git submodule foreach --post-order 'frotz' # Do 'frotz' post-order in
>> each submodule
> 
> OK.
> 
>> git submodule foreach --pre-order='frotz' --post-order='shimmy' # Do
>> 'frotz' pre-order and 'shimmy' post-order in each submodule
> 
> OK.
> 
>> git submodule foreach --post-order='shimmy' 'frotz' # Invalid usage of
>> the command
> 
> I would expect this to behave exactly the same as:
> 
> 	git submodule foreach \
>         	--post-order=shimmy \
>                 --pre-order=frotz
> 
>> git submodule foreach --post-order --pre-order #
> 
> I expect it to behave exactly the same as:
> 
> 	git submodule foreach --post-order=: --pre-order=:

I'd favor to just drop the --pre-order option and do this:

  foreach [--recursive] [--post-order <command>] [<command>]

Me thinks pre-order is a sane default and we shouldn't add an
explicit option for that. And even with current Git you can
simply give no command at all and it'll show you all the
submodules it enters without doing anything in them, so we'd
only need to add the --post-order handling anyway (and fix the
synopsis by adding square brackets around the command while at
it, as that is optional).

>> It should not be too hard to have this functionality affect the
>> --include-super command as well.
> 
> I would assume that
> 
> 	git submodule foreach --pre-order=A --post-order=B --include-super
> 
> would be identical to running
> 
> 	A &&
>         git submodule foreach --pre-order=A --post-order=B &&
>         B
>
> I am not entirely convinced we would want --include-super in the
> first place, though.  It does not belong to "submodule foreach";
> it is doing something _outside_ the submoudules.

I totally agree with that. First, adding --include-super does not
belong into the --post-order patch at all, as that is a different
topic (even though it belongs to the same use case Eric has). Also
the reason why we are thinking about adding the --post-order option
IMO cuts the other way for --include-super: It is so easy to do
that yourself I'm not convinced we should add an extra option to
foreach for that, especially as it has nothing to do with submodules.
So I think we should just drop --include-super.
