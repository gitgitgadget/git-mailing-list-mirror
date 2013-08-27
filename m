From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/23] pack v4: creation code
Date: Tue, 27 Aug 2013 08:48:24 -0700
Message-ID: <xmqqppszdtiv.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-13-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELVQ-0008Mi-P4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab3H0Ps2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:48:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3H0Ps1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:48:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 067D23A145;
	Tue, 27 Aug 2013 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Cuml6WqOTBTXha5UAC8voiYsgs=; b=QpuuRm
	VTBuF76a4cnVoS10KXHiWPmYHrIV3oBdH3wUO+4+P/qXu0He4fqlsT5bE6gd3s9M
	S2cqYjgXauUaP2snJ+j9cgobfbqtNCirx2gMLDIYLhdj21Z9RKGwwj6ZT3iRdca8
	WNXzIFqou5W9gm7FNP5oL6VBLndPtHXkkvvlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iCibW6wup+TiCa2ZjcKO4Cqd5s5OKcpO
	NMtbMh+XJbnVk2Ko71K9wDcmNUv1DYNIpDVjBLq91D/7W8yPAoYTpzOkOS7xmuJz
	Vk/DlbXnj/wPuhV4UyIroPIMpSDai2rwIO5/tPac+YfwLjmaOsVg/Cyzwa4nP1YT
	3dmW1+zbYAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDA813A144;
	Tue, 27 Aug 2013 15:48:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210AC3A13B;
	Tue, 27 Aug 2013 15:48:26 +0000 (UTC)
In-Reply-To: <1377577567-27655-13-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C740050-0F30-11E3-97F9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233105>

Nicolas Pitre <nico@fluxnic.net> writes:

> Let's actually open the destination pack file and write the header and
> the tables.
>
> The header isn't much different from pack v3, except for the pack version
> number of course.
>
> The first table is the sorted SHA1 table normally found in the pack index
> file.  With pack v4 we write this table in the main pack file instead as
> it is index referenced by subsequent objects in the pack.  Doing so has
> many advantages:
>
> - The SHA1 references used to be duplicated on disk: once in the pack
>   index file, and then at least once or more within commit and tree
>   objects referencing them.  The only SHA1 which is not being listed more
>   than once this way is the one for a branch tip commit object and those
>   are normally very few.  Now all that SHA1 data is represented only once.
>

This tickles my curiosity. Why isn't this SHA-1 table sorted by
reference count the same way as the tree path and the people name
tables to keep the average length of varint references short?

> - The SHA1 references found in commit and tree objects can be obtained
>   on disk directly without having to deflate those objects first.
>
> The SHA1 table size is obtained by multiplying the number of objects by 20.
>
> And then the commit and path dictionary tables are written right after
> the SHA1 table.

> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index 2956fda..5211f9c 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -605,6 +605,48 @@ static unsigned long write_dict_table(struct sha1file *f, struct dict_table *t)
>  	return hdrlen + datalen;
>  }
>  
> +static struct sha1file * packv4_open(char *path)
> +{
> +	int fd;
> +
> +	fd = open(path, O_CREAT|O_EXCL|O_WRONLY, 0600);
> +	if (fd < 0)
> +		die_errno("unable to create '%s'", path);
> +	return sha1fd(fd, path);
> +}
> +
> +static unsigned int packv4_write_header(struct sha1file *f, unsigned nr_objects)
> +{
> +	struct pack_header hdr;
> +
> +	hdr.hdr_signature = htonl(PACK_SIGNATURE);
> +	hdr.hdr_version = htonl(4);
> +	hdr.hdr_entries = htonl(nr_objects);
> +	sha1write(f, &hdr, sizeof(hdr));
> +
> +	return sizeof(hdr);
> +}
> +
> +static unsigned long packv4_write_tables(struct sha1file *f, unsigned nr_objects,
> +					 struct pack_idx_entry *objs)
> +{
> +	unsigned i;
> +	unsigned long written = 0;
> +
> +	/* The sorted list of object SHA1's is always first */
> +	for (i = 0; i < nr_objects; i++)
> +		sha1write(f, objs[i].sha1, 20);
> +	written = 20 * nr_objects;
> +
> +	/* Then the commit dictionary table */
> +	written += write_dict_table(f, commit_name_table);
> +
> +	/* Followed by the path component dictionary table */
> +	written += write_dict_table(f, tree_path_table);
> +
> +	return written;
> +}
> +
>  static struct packed_git *open_pack(const char *path)
>  {
>  	char arg[PATH_MAX];
> @@ -658,9 +700,10 @@ static struct packed_git *open_pack(const char *path)
>  	return p;
>  }
>  
> -static void process_one_pack(char *src_pack)
> +static void process_one_pack(char *src_pack, char *dst_pack)
>  {
>  	struct packed_git *p;
> +	struct sha1file *f;
>  	struct pack_idx_entry *objs, **p_objs;
>  	unsigned nr_objects;
>  
> @@ -673,15 +716,22 @@ static void process_one_pack(char *src_pack)
>  	p_objs = sort_objs_by_offset(objs, nr_objects);
>  
>  	create_pack_dictionaries(p, p_objs);
> +
> +	f = packv4_open(dst_pack);
> +	if (!f)
> +		die("unable to open destination pack");
> +	packv4_write_header(f, nr_objects);
> +	packv4_write_tables(f, nr_objects, objs);
>  }
>  
>  int main(int argc, char *argv[])
>  {
> -	if (argc != 2) {
> -		fprintf(stderr, "Usage: %s <packfile>\n", argv[0]);
> +	if (argc != 3) {
> +		fprintf(stderr, "Usage: %s <src_packfile> <dst_packfile>\n", argv[0]);
>  		exit(1);
>  	}
> -	process_one_pack(argv[1]);
> -	dict_dump();
> +	process_one_pack(argv[1], argv[2]);
> +	if (0)
> +		dict_dump();
>  	return 0;
>  }
