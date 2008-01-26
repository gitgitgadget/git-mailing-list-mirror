From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add builtin dump command, to query a repository using a pipe.
Date: Sat, 26 Jan 2008 01:35:44 -0800
Message-ID: <7vve5hyln3.fsf@gitster.siamese.dyndns.org>
References: <fnduk3$d0c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIhSe-0000Rv-QT
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 10:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYAZJf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 04:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYAZJf4
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 04:35:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYAZJfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 04:35:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E66E2D7A;
	Sat, 26 Jan 2008 04:35:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F4952D79;
	Sat, 26 Jan 2008 04:35:46 -0500 (EST)
In-Reply-To: <fnduk3$d0c$1@ger.gmane.org> (Han-Wen Nienhuys's message of "Fri,
	25 Jan 2008 16:24:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71767>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> This command prints either contents or metadata on stdout for SHA1s or
> symbolic object names supplied to its stdin, so you can extract many
> pieces of data of the repository using a single subprocess.
>
> Documentation will follow once the code is approved.

I will comment on this part at the end.

> +typedef unsigned char sha1_t[20];

Hmph.  We do not seem to do typedefs like this elsewhere.  Would
it be worth doing so everywhere?  I generally stay away from a
new type that is "an array of some type".

> +void print_metadata(struct strbuf command_buf) {

Style.  "{" at the beginning of a function goes to the beginning
of a line.

Are you sure you want to pass "struct strbuf" by value?  As you
do not use anything other than its .buf, you may instead want to
make the parameter "const char *" and have the caller do buf.buf
business.

> +	char *obj_name = strchr(command_buf.buf, ' ') + 1;

Wasts reader's time by making him wonder if this needs to check
for malformed command buffer.  The answer happens to be no only
because the caller does something stupid ;-)

	if (!prefixcmp(command_buf.buf, "metadata "))
		print_metadata(command_buf);
	
and the strchr is guaranteed to find that ' ' after metadata.

	if (!prefixcmp(command_buf.buf, "metadata "))
        	print_metadata(command_buf.buf + 9);

would give you the beginning of obj_name in the parameter
without any need for the strchr().

> +	sha1_t sha1 = {0};
> +	const char *type_name = "none";
> +	unsigned long size = 0;
> +	char header[200];
> +
> +	if (!get_sha1(obj_name, sha1)) {
> +		enum object_type type = sha1_object_info(sha1, &size);
> +		type_name = type ? typename(type) : "none";
> +	}
> +	sprintf(header, "%s %lu %s\n", type_name, size, sha1_to_hex(sha1));
> +	write_or_die(1, header, strlen(header));  
> +}
> +
> +
> +void print_show(struct strbuf command_buf) {
> +	char *type = strchr(command_buf.buf, ' ') + 1;

Likewise.

> +	char *obj_name;
> +	sha1_t sha1;
> +	unsigned long size;
> +	char header[200];
> +	void *buf;
> +	
> +	if (!type)
> +		die("commmand format error: %s\n", command_buf.buf);

Especially, this will never trigger, although "if (!*type)" would.

> +  
> +	obj_name = strchr(type, ' ');
> +	if (!obj_name)
> +		die("commmand format error: %s\n", command_buf.buf);

I am not sure if this interface that "die()"s on an obviously
malformed input is nice to the user (which is the process at the
other end of the pipe).  It only gets abrupt disconnection
without any diagnosis.  But the user may deserve it, as it is
about "obviously malformed" input.  I do not have strong opinion
about this.

> +	*obj_name = '\0';
> +	obj_name++;
> +  
> +	if (get_sha1(obj_name, sha1))
> +		die("not a valid object name: %s", obj_name);
> +  
> +	buf = read_object_with_reference(sha1, type, &size, NULL);

This is not nice and definitely needs to be tightened for a case
where the object does not exist in this repository.  Otherwise
safe use of this dump "server" will require one "metadata" query
to protect "print" query from barfing for each object.

> +	sprintf(header, "len %lu\n", size);
> +	write_or_die(1, header, strlen(header));
> +	write_or_die(1, buf, size);
> +	write_or_die(1, "\n", 1);
> +}

IOW, this needs an if() statement that triggers upon (buf == NULL)
to return an error message back to the other end.

Now, back to the proposed commit log message.

> Documentation will follow once the code is approved.

This sends a wrong message to the list audiences.  It roughly
says:

    I wrote something new.  It is used to read many pieces of
    data without having to spawn a subprocesses per request.
    Isn't it nice?

    Oh, by the way, I am not giving you more than the absolute
    minimum information right now, the code, to let you become
    qualified to say "Ah, yes, that new feature makes sense, it
    meshes well with the way how the rest of the system works,
    and I think it is a good addition to the git.git project".
    If you really want to know how it interfaces to the outside
    world (i.e. how the input is structured is parsed, and how
    the output is structured and is designed to be parsed, how
    errors are reported), go read it.

    But trust me, it's a good code, and you will have
    documentation once it is accepted anyway.

But the external interface matters.  It often matters more than
the details of how the interface is implemented (which is the
code).  If the interface is wrong, time spent on reading and
commenting on the code is often wasted.  I had to read all the
code to notice that I may not necessarily agree with the
response of the command to a malformed input, or missing
objects.  If it was documented, it would have been more obvious
and many other people would have responded, including the ones
who may not be inclined to work on or review dump "server"
implementation side written in C, but are _very much_ interested
in using such a server as a client, perhaps from their
higher-level language scripts.

If the patch was about a completely new command and sizeable, it
is very likely that I might have felt defeated and said "Ah, Ok,
I choose to stay unqualified to judge this patch to say 'yes,
this is a good idea', if I have to wade through that amount of
code".  Most likely many others would do the same.

Please don't do that again.  It also gives a false impression
that this kind of submission is an appropriate and acceptable
approach to people new to the list.
