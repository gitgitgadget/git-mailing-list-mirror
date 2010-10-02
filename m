From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sat, 2 Oct 2010 13:26:00 -0500
Message-ID: <20101002182600.GB24523@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002084100.GH29638@burratino>
 <AANLkTikZ5cn8biMvMPzXz6U2J=3yg1KJXayHD-7Cx8Me@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 20:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P26qW-0003hb-Ox
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 20:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab0JBS3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 14:29:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57078 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0JBS3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 14:29:10 -0400
Received: by iwn5 with SMTP id 5so5156658iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o0xTUTV6Pwy0O4sA976LkVvSbvQL5f1ZsBWf4jPX+NY=;
        b=b8ApQH9F/K4Y/UIS3Z93ECKnPWlHDa4g8ADB5V05Kl8qFJrn3wb6LeGfl0FCG5jICq
         qFLmLesvPFfNUNtEtk9dD0T2tXOF4R4OK8/HMSFNu4zbnwpCAAuA6EqIGhnmsa2n/9Ed
         BoEJzxFBhVxWEDAkodIJQxgUpYGhL5T3kDeKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xCDvfhx9oF2PuiGIFkuvjJt4SocX8JPtZkoN+L2efcr4I2kqEYC7Gqe6HU+vR1mJFt
         hcEFw/i0Ijw2Xl9xvq0dPXDRtdsSwqaro1PHwaD481ob+xF0f6Flb6jB0Yuk7bzrVtF6
         oEd/oIklXSgkGlbPUBlfTBc8sEx5YyFlJ78GA=
Received: by 10.231.33.71 with SMTP id g7mr7574137ibd.54.1286044150374;
        Sat, 02 Oct 2010 11:29:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r3sm2718664ibk.7.2010.10.02.11.29.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 11:29:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikZ5cn8biMvMPzXz6U2J=3yg1KJXayHD-7Cx8Me@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157811>

Sverre Rabbelier wrote:
> On Sat, Oct 2, 2010 at 10:41, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> That's the end of the series. =C2=A0Thanks for reading.
>
> Thanks, I've used git under valgrind a couple of times and always had
> to resort to running 'regular' git, looking at what valgrind reports
> for it, and then running my modified git, and try to make sure that I
> didn't introduce any new leaks. How does the current valgrind output
> look like, are we close to being leak free, or is this just a drop in
> (or perhaps out of :P) the bucket?

It is a drop in the bucket.  With some extra suppressions[1], I am
only able to run t0000 through valgrind.

Probably this series should cook outside mainline until the test suite
runs without reporting any unsuppressed leaks.  I still would be
interested in more comments on the approach, though.  If KEEP_WRAPPER
were conditionally defined to be empty (so by default people _would_
find the tail calls in those sentinel functions eliminated --- i.e.,
no performance impact unless you ask for it), would that be more
acceptable?

[1]
 {
	cache entry leak
	Memcheck:Leak
	fun:calloc
	fun:xcalloc
	fun:add_one_path
 }
 {
	cache entry leak 2
	Memcheck:Leak
	fun:calloc
	fun:xcalloc
	fun:unpack_callback
 }
 {
	nobody seems to free tree buffers
	Memcheck:Leak
	fun:malloc
	fun:xmalloc
	fun:xmallocz
	fun:unpack_sha1_file
	fun:read_object
	fun:read_sha1_file_repl
	fun:parse_object
	fun:parse_tree_indirect
 }
 {
	really, nobody seems to free tree buffers
	Memcheck:Leak
	fun:malloc
	fun:xmalloc
	fun:xmallocz
	fun:unpack_sha1_file
	fun:read_object
	fun:read_sha1_file_repl
	fun:parse_tree
 }
