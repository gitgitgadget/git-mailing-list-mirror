From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 17:27:32 -0400
Message-ID: <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 23:28:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7EnZ-0004ei-IS
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250Ab0D1V1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 17:27:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62181 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab0D1V1x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 17:27:53 -0400
Received: by gwj19 with SMTP id 19so5104323gwj.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UzWn2l6nR4ULJ9azZ5YWzieKbKFIPKq95lkKvbfZ0ys=;
        b=pbBVcIFvML27MCLXg4cKEFMqfhvyiEOJsvyU8YPGLK2J7G2kPLziwwH1RTV9h/b8rN
         LDQNm1Z8AKWiv9SENryoBGMi4IzRVkKrr8awyTW/P6ZmF5v87SQyNbkbhoavKLG5IeuO
         9OdNSaAeQn/+r/bAa8JenwApL2YIZn20vBAX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sOtGk6BK40AsCuX1HnUQpQpgRN/cJW9LkH+B4I9Itiel+UyGQkUgR69+geL3bvRlPK
         GAMibDrpJEL403ih4E//o7aTL+IBBIU7l1vxwC4yfDaDqbp+7pSjBfu1xBiE0EGwFQuf
         tUE2ogEgRuLBRE3TdQ0Ich1nvvdwX6ADC69s0=
Received: by 10.151.92.9 with SMTP id u9mr370452ybl.336.1272490072181; Wed, 28 
	Apr 2010 14:27:52 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Wed, 28 Apr 2010 14:27:32 -0700 (PDT)
In-Reply-To: <loom.20100428T204406-308@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146015>

On Wed, Apr 28, 2010 at 3:13 PM, Sergio Callegari
<sergio.callegari@gmail.com> wrote:
> Avery Pennarun <apenwarr <at> gmail.com> writes:
>> I'm not sure it would help very much for these sorts of files. =A0Th=
e
>> problem is that compressed files tend to change a lot even if only a
>> few bytes of the original data have changed.
>
> Probably I have not provided enough elements... My idea is the follow=
ing:
>
> If you store a structured file as a multiblob, you can use a blob for=
 each
> uncompressed element of content. =A0For instance, when storing an ope=
ndocument
> file you could use a blob for manifest.xml, one for content.xml, etc.=
=2E. (try
> unzip -l on an odt or odp file to get an idea). When you edit your fi=
le only a
> few of these change. For instance, if we talk about a presentation, e=
ach slide
> has its own content.xml, so changing one slide only that changes.

But why not use a .gitattributes filter to recompress the zip/odp file
with no compression, as I suggested?  Then you can just dump the whole
thing into git directly.  When you change the file, only the changes
need to be stored thanks to delta compression.  Unless your
presentation is hundreds of megs in size, git should be able to handle
that just fine already.

> The same for PDF files, if you split them using a blob for each uncom=
pressed
> stream, little variations of the pdf file will touch only a blob.

But then you're digging around inside the pdf file by hand, which is a
lot of pdf-specific work that probably doesn't belong inside git.
Worse, because compression programs don't always produce the same
output, this operation would most likely actually *change* the hash of
your pdf file as you do it.  (That's also true for openoffice files,
but at least those are just plain zip files, and zip files are
somewhat less of a special case.)

>> For things like opendocument, or uncompressed tars, you'd be better
>> off to decompress them (or recompress with zip -0) using
>> .gitattributes. =A0Generally these files aren't *so* large that they
>> really need to be chunked; what you want to do is improve the deltas=
,
>> which decompressing will do.
>
> This is what I currently do. =A0But using multiblobs would be a defin=
ite
> improvement over this.

In what way?  I doubt you'd get more efficient storage, at least.
Git's deltas are awfully hard to beat.

>> That sounds complicated and error prone, and is suspiciously like
>> Apple's "resource forks," which even Apple has mostly realized were =
a
>> bad idea.
>
> I did not mean the Apple way... Suppose that you need to store images=
 with exif
> tags. =A0In order to diff them you would tipically set a textconv att=
ribute, to
> see only the tags. =A0However, this kind of filter needs to read the =
whole file
> (expensive). BTW this is why a caching mechanism involving notes has =
recently
> been proposed. Now suppose that you can set up a rule so that image f=
iles with
> tags are stored as a multiblob. You can use 3 blobs... 1 as a header,=
 one for
> the raw image data and one for the tags. =A0Now your textconv filter =
only needs to
> look at the content of the tags blob.

A resource fork by any other name is still a resource fork, and it's
still ugly.  If you really need something like this, just cache the
attributes in a file alongside the big file, and store both files in
the git repo.

> Similar... Right now to do package management with git, you need to u=
se pristine
> tar. This is because when you check in the upstream tar you only chec=
k in its
> elements, not the whole tar.gz. =A0So you need pristine tar to recrea=
te the
> upstream tar.gz whenever needed. But with multiblob you could store b=
oth the
> content /and/ the upstream tar and there would be minimal overlap sin=
ce the
> blobs would be the same.

I guess.  For something like that, though, Debian's pristine-tarball
tool seems to already solve the problem and works with any VCS, not
just git.

>> Sharing the blobs of a tarball with a checked-out tree would require=
 a
>> tar-specific chunking algorithm. =A0Not impossible, but a pain, and =
you
>> might have a hard time getting it accepted into git since it's
>> obviously not something you really need for a normal "source code"
>> tracking system.
>
> I agree... but there could be just a mere couple of gitattributes mul=
tiblobsplit
> and multiblobcompose, so that one could provide his own splitting and=
 composing
> methods for the types of files he is interested in (and maybe contrib=
ute them to
> the community).

I guess this would be mostly harmless; the implementation could mirror
the filter stuff.

> I am not really thinking that much about large binary files (that wou=
ld anyway
> come as a bonus - an many people often talk about them on the list), =
but of
> structured files that currently do not pack well. =A0My personal issu=
e is with
> opendocument files, since I need to check in lots of documentation an=
d
> presentation material.

In that case, I'd like to see some comparisons of real numbers
(memory, disk usage, CPU usage) when storing your openoffice documents
(using the .gitattributes filter, of course).  I can't really imagine
how splitting the files into more pieces would really improve disk
space usage, at least.

Having done some tests while writing bup, my experience has been that
chunking-without-deltas is great for these situations:
1) you have the same data shared across *multiple* files (eg. the same
images in lots of openoffice documents with different filenames);
2) you have the same data *repeated* in the same file at large
distances (so that gzip compression doesn't catch it; eg. VMware
images)
3) your file is too big to work with the delta compressor (eg. VMware i=
mages).

However, in my experience #1 is pretty rare and #2 and #3 aren't in
your use case.  And deltas-between-chunks is not very easy to do,
since it's hard to guess which chunks might be "similar" to which
other chunks.

Personally, I think it would be great if git could natively handle
large numbers of large binary files efficiently, because there are a
few use cases I would have for it.  But whenever I start investigating
my use cases, it always turns out that just "supporting large files"
is just the tip of the iceberg, and there's a huge submerged mass of
iceberg that becomes obvious as soon as you start crashing into it.

The bup use case (write-once, read-almost-never, incremental backups)
is a rare exception in which fixing *only* the file size problem has
produced useful results.

Have fun,

Avery
