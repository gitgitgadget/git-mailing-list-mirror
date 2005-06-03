From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 10:24:14 -0700
Message-ID: <7vk6lbmk01.fsf@assigned-by-dhcp.cox.net>
References: <20050603152212.GA4598@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Jun 03 19:23:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeFrR-00079C-3m
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 19:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFCRYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 13:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFCRYk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 13:24:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24773 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261405AbVFCRYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 13:24:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603172415.JYJC16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 13:24:15 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050603152212.GA4598@jmcmullan.timesys> (Jason McMullan's
 message of "Fri, 3 Jun 2005 11:22:12 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Looks very nice.  Some comments.

    diff -u b/daemon.c b/daemon.c
    --- b/daemon.c
    +++ b/daemon.c
------------
    +
    +/* Protocol is symmetric, both client and server
    + * use the same commands.
    + *
    + * version\n -> error -- 0 <Version string>\n
    + *
    + * head <head-id>\n -> sha1 <head-id> <sha1>\n
    + *
    + * head <head-id> <old-sha1> <new-sha1>\n -> sha1 <head-id> <new-sha1>\n
    + *
    + * request <sha1>\n -> send <sha1> <hex-bytes>\n<bytes...>
    + *
    + * send <sha1> <hex-bytes>\n<bytes...> -> sha1 -- <sha1>\n
    + *
    + * exists <sha1>\n -> sha1 -- <sha1>\n
    + *
    + * sha1 <any> <sha1>\n -> no-op
    + *
    + * error <key> <hex-code> <error string>\n -> no-op
    + *
    + */

This is good for the first cut, but I have a latency concern
about "single request - single send" style of communication.
This being a dedicated GIT specific sync mechanism, you may want
to give more smarts to the server, so that the client can say "I
have these commits as HEADs in my forest, here are their SHA1s,
now sync me up to the head you said you have whose SHA1 is
this", implying he has all their HEADs dependents.  Of course
this can come later.

------------

    +static int verify_file(int fd, unsigned long mapsize, const unsigned char *sha1, char *type)
    +{
    +	void *map, *buffer;
   ~~~ 
    +		if (buffer && !strcmp(type, "delta")) {
    +			void *ref = NULL, *delta = buffer;
    +			unsigned long ref_size, delta_size = size;
    +			buffer = NULL;
   ~~~
    +			buffer = patch_delta(ref, ref_size,
    +					  delta+20, delta_size-20, 
    +					  &size);
    +			free(delta);
    +			free(ref);
    +		}

A possibility is to chuck the above special case for "delta",
and instead introduce "delta" subclass in struct object family
and make the base object of "delta" simply one object on the
obj->refs list on such a "delta" object.  I would imagine that
this would let you reuse the sha1_retrieve() loop that you
already do for "commit", "tree", and "tag".

    +		if (!strcmp(type, "blob")) {
    +			struct blob *blob = lookup_blob(sha1);
    +			parse_blob_buffer(blob, buffer, size);
   ~~~
    +			obj = &tag->object;
    +		} else {
    +			obj = NULL;
    +		}
    +
    +		free(buffer);
    +
    +		if (obj) {
    +			struct object_list *refs;
    +
    +			for (refs = obj->refs; refs ; refs = refs->next) {
    +				err = sha1_retrieve(refs->item->sha1);
    +				if (err < 0)
    +					return err;
    +			}
    +		
    +			return 0;
    +		}
    +
    +	}
    +	return -1;
    +}

------------

    +static int send_send(const unsigned char *sha1, int size, void *data)
    +{
   ~~~
    +}
   ~~~
    +static int cmd_request(int argc, char **argv)
    +{
    +	int err;
    +
    +	if (argc == 2) {
    +		char sha1[40];
    +		void *data;
    +		unsigned long size;
   ~~~
    +		err = send_send(sha1, size, data);
    +		if (err < 0)
    +			return err;

By definition, size of SHA1 blob is "unsigned long" so
send_send() should take such not "int".

