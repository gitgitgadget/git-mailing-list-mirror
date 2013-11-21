From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 08:42:09 -0600
Message-ID: <87ppptolz2.fsf@gmail.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121114837.GB7171@sigill.intra.peff.net>
	<CACsJy8B5xY1FZyhPdct8Nt6Gad2cveRvmOXTXJP=uCaG2_0KuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 15:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjVSe-0008EF-32
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 15:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418Ab3KUOmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 09:42:23 -0500
Received: from plane.gmane.org ([80.91.229.3]:35100 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab3KUOmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 09:42:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VjVSV-0008At-OY
	for git@vger.kernel.org; Thu, 21 Nov 2013 15:42:19 +0100
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 15:42:19 +0100
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 15:42:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:iJDih5z9YzBpe6G6c9KpfflGYXE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238123>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Nov 21, 2013 at 6:48 PM, Jeff King <peff@peff.net> wrote:
>> @@ -1514,14 +1469,6 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>>
>>  int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
>>  {
>> -       unsigned long size, used;
>> -       static const char valid_loose_object_type[8] = {
>> -               0, /* OBJ_EXT */
>> -               1, 1, 1, 1, /* "commit", "tree", "blob", "tag" */
>> -               0, /* "delta" and others are invalid in a loose object */
>> -       };
>> -       enum object_type type;
>> -
>>         /* Get the data stream */
>>         memset(stream, 0, sizeof(*stream));
>>         stream->next_in = map;
>> @@ -1529,27 +1476,6 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>>         stream->next_out = buffer;
>>         stream->avail_out = bufsiz;
>>
>> -       if (experimental_loose_object(map)) {
>
> Perhaps keep this..
>
>> -               /*
>> -                * The old experimental format we no longer produce;
>> -                * we can still read it.
>> -                */
>> -               used = unpack_object_header_buffer(map, mapsize, &type, &size);
>> -               if (!used || !valid_loose_object_type[type])
>> -                       return -1;
>> -               map += used;
>> -               mapsize -= used;
>> -
>> -               /* Set up the stream for the rest.. */
>> -               stream->next_in = map;
>> -               stream->avail_in = mapsize;
>> -               git_inflate_init(stream);
>> -
>> -               /* And generate the fake traditional header */
>> -               stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
>> -                                                typename(type), size);
>> -               return 0;
>
> and replace all this with
>
> die("detected an object in obsolete format, please repack the
> repository using a version before XXX");
>
> ?

Wouldn't that fail to solve the issue of `git fsck` dying on corrupt
data?  experimental_loose_object() would need to be rewritten to be more
conservative in deciding that an object was in the experimental loose
object format.

-Keshav
