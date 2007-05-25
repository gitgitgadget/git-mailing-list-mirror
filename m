From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 12:22:28 -0700
Message-ID: <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
References: <46569C37.5000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 21:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrfN9-0003Py-GD
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXEYTWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764106AbXEYTWb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:22:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54338 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763969AbXEYTW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 15:22:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525192229.OPEA22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 15:22:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3XNU1X00P1kojtg0000000; Fri, 25 May 2007 15:22:29 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48400>

Dana How <danahow@gmail.com> writes:

> Nicolas Pitre wrote:
>> I wouldn't mind a _separate_ tool that would load a pack index,
>> determine object sizes from it, and then extract big objects to write
>> them as loose objects ...
>
> Below we add two new options to git-unpack-objects:
>
> --min-blob-size=<n>::  Unpacking is only done for objects
> larger than or equal to n kB (uncompressed size by Junio).

Elsewhere you wanted to use --max-* and that was counted in megs;
isn't using kilo here and meg there inconsistent?

> --force::  Loose objects will be created even if they
> already exist in the repository packed.  This is an option
> I've wanted before for other reasons.

        ... but if they already exist in the repository as loose
        objects, do not replace it.

Usually we do not overwrite existing loose objects and it is one
of the security measure --- if you have an object already, that
cannot be touched by somebody who maliciously creats a hash
colliding loose object and tries to inject it into your
repository via unpack-objects.  It's good that you kept this
behaviour intact.

> This passes the tests in "t" but has not yet been used on my large repos.
> Based on "next" but should apply to "master" as well.
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  Documentation/git-unpack-objects.txt |   17 +++++++++++++----
>  builtin-unpack-objects.c             |   20 ++++++++++++++++++--
>  cache.h                              |    2 ++
>  sha1_file.c                          |   11 +++++++++--
>  4 files changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
> index ff6184b..4513d8d 100644
> --- a/Documentation/git-unpack-objects.txt
> +++ b/Documentation/git-unpack-objects.txt
> ...
> @@ -17,9 +17,10 @@ Read a packed archive (.pack) from the standard input, expanding
>  the objects contained within and writing them into the repository in
>  "loose" (one object per file) format.
>  
> -Objects that already exist in the repository will *not* be unpacked
> -from the pack-file.  Therefore, nothing will be unpacked if you use
> -this command on a pack-file that exists within the target repository.
> +By default,  objects that already exist in the repository will *not*
> +be unpacked from the pack-file.  Therefore, nothing will be unpacked
> +if you use this command on a pack-file that exists within the target
> +repository,  unless you specify --force.

I would want to add:

	If an object already exists unpacked in the repository,
	it will not be replaced with the copy from the pack,
	with or without `--force`.

> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> index a6ff62f..a42bf0d 100644
> --- a/builtin-unpack-objects.c
> +++ b/builtin-unpack-objects.c
> @@ -10,13 +10,16 @@
>  #include "progress.h"
>  
>  static int dry_run, quiet, recover, has_errors;
> -static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
> +static const char unpack_usage[] =
> +"git-unpack-objects [-n] [-q] [-r] [--force] [--min-blob-size=N] < pack-file";

Maybe we would want to call it '-f' for consistency.  Another
possibility is the other way around, giving others a longer
synonyms, like --quiet, but this command is plumbing and I do
not think long options matters that much, so my preference is to
do '-f' not '--force'.

> @@ -131,7 +134,9 @@ static void added_object(unsigned nr, enum object_type type,
>  static void write_object(unsigned nr, enum object_type type,
>  			 void *buf, unsigned long size)
>  {
> -	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
> +	int force2 = size < min_blob_size ? -1 : force;
> +	if (write_sha1_file_maybe(buf, size, typename(type),
> +				  force2, obj_list[nr].sha1) < 0)
>  		die("failed to write object");
>  	added_object(nr, type, buf, size);
>  }

Without --min-blob-size option, min_blob_size is initialized to
0u and force2 always gets the value of force.  With the option,
blobs smaller than the threshold gets -1 and otherwise the value
of force.

"write_sha1_file_maybe()" can take 0, 1, or -1 as its fourth
parameter.  The reader is left puzzled what the distinction
among these three and decides to read on to figure it out before
complaining too much about the code, but no matter what it does,
doesn't the above logic already feel wrong?

 * You already have the size here, so if min_blob_size is set
   and the size is larger, you do not even have to call
   write_sha1_file() at all.

 * If you do so, write_sha1_file_maybe()'s additional parameter
   can be "skip the check to see if we have one packed".

> diff --git a/cache.h b/cache.h
> index ec85d93..d0c3030 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -343,6 +343,8 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
>  extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
>  extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
>  extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
> +extern int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
> +				 int ignore, unsigned char *return_sha1);
>  extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
>  
>  extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);

... and it says "ignore".  The reader is still puzzled and reads on...

> diff --git a/sha1_file.c b/sha1_file.c
> index 12d2ef2..68b8db8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1979,7 +1979,8 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
>  	return 0;
>  }
>  
> -int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
> +int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
> +			  int ignore, unsigned char *returnsha1)
>  {
>  	int size, ret;
>  	unsigned char *compressed;
> @@ -1997,7 +1998,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
>  	filename = sha1_file_name(sha1);
>  	if (returnsha1)
>  		hashcpy(returnsha1, sha1);
> -	if (has_sha1_file(sha1))
> +	if (ignore < 0 || !ignore && has_sha1_file(sha1))
>  		return 0;
>  	fd = open(filename, O_RDONLY);
>  	if (fd >= 0) {

So "ignore" means:

        negative:       never write it out, even if it does not exist.

        zero:           do not write it out if it is available (in pack,
                        or loose, either local or alternate), do
                        write it out otherwise; it is the same
                        as the current behaviour of write_sha1_file().

        positive:       always write it out.

That does not sound like "ignore".

My suggestion would be:

>  static void write_object(unsigned nr, enum object_type type,
>  			 void *buf, unsigned long size)
>  {
        if (!min_blob_size || size < min_blob_size) {
             if (write_sha1_file_maybe(buf, size, typename(type),
                             force, obj_list[nr].sha1) < 0)
                     die("failed to write object");
             }
        }
 	added_object(nr, type, buf, size);
>  }

And then.

int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
		int make_loose, unsigned char *returnsha1)
{
	...
>  	filename = sha1_file_name(sha1);
>  	if (returnsha1)
>  		hashcpy(returnsha1, sha1);
	if (!make_loose && has_sha1_file(sha1))
>  		return 0;
>  	fd = open(filename, O_RDONLY);
>  	if (fd >= 0) {
