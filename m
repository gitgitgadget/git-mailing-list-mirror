From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Tue, 2 Apr 2013 03:36:43 -0600
Message-ID: <CAMP44s2PT4YWBNJGTaYS5oy2jBEqkGFhwGjmZZc+HLsS8MO_xA@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
	<20130401233313.GB30935@sigill.intra.peff.net>
	<CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
	<20130402023024.GB719@sigill.intra.peff.net>
	<CAMP44s2VcLUE=PHE=iSsgd67_ZV4N6b5Ya76Rc22xtSzK-Xz0g@mail.gmail.com>
	<20130402050154.GA21328@sigill.intra.peff.net>
	<CAMP44s3yNGfW4aoHB90_D-OFrzchgvAugzdmOYHOey3wYkUxjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 11:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMxeV-0007ve-RW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 11:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760676Ab3DBJgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 05:36:48 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:61804 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3DBJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 05:36:45 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so197483lab.28
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PS1mWRuY3J2WInjtyhuJDvFJj/oyvmFMBiwt9LL8614=;
        b=l88i9aueREOP3s+gKgY398urlbIf+SBBfgdffdtem91ZFFCJ5XJy890WXDCz+C0u4F
         HtY2TAFMehvaKzD0nB+VxckkLPxgyD7fd0bZIyA9iUGiHdHU773ZD02LD5bgsMsipwyI
         sOnfchO7tw4y8dKkqIVHFgKHG8qV3/gPRiGqoYbQr3aNGabMSD8nft0TeVlyN6g+QKSk
         v/Bg8sMtDBD59hvOO29eZxavgak34n1Tb+tXPYHDxHRoHEu454dRtXJ8epJKhYeH3xX4
         oIje7vXSluCwHDQT7sCeXUiHY1wEBD8faVn8dXYqAPmlsRSJdUnauLGgAKgOwxr/fN8m
         ck0w==
X-Received: by 10.152.128.98 with SMTP id nn2mr7376844lab.17.1364895403981;
 Tue, 02 Apr 2013 02:36:43 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Tue, 2 Apr 2013 02:36:43 -0700 (PDT)
In-Reply-To: <CAMP44s3yNGfW4aoHB90_D-OFrzchgvAugzdmOYHOey3wYkUxjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219760>

On Mon, Apr 1, 2013 at 11:19 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Apr 1, 2013 at 11:01 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Apr 01, 2013 at 10:51:20PM -0600, Felipe Contreras wrote:
>>
>>> > So in fetch_with_import, we have a remote-helper, and we have a
>>> > bidirectional pipe to it. We then call get_importer, which starts
>>> > fast-import, whose stdin is connected to the stdout of the remote
>>> > helper. We tell the remote-helper to run the import, then we wait for
>>> > fast-import to finish (and complain if it fails).
>>> >
>>> > Then what? We seem to do some more work, which I think is what causes
>>> > the errors you see; but should we instead be reaping the helper at this
>>> > point unconditionally? Its stdout has presumably been flushed out to
>>> > fast-import; is there anything else for us to get from it besides its
>>> > exit code?
>>>
>>> The problem is not with import, since fast-import would generally wait
>>> properly for a 'done' status, the problem is with export.
>>
>> Your patch modified fetch_with_import. Are you saying that it isn't
>> necessary to do so?
>
> It's not, I added it for symmetry. But that's the case *if* the
> remote-helper is properly using the "done" feature.

Actually, it is a problem, because without this check the
transport-helper just goes on without realizing the whole thing has
failed and doesn't produce a proper error message:

fatal: bad object 0000000000000000000000000000000000000000
error: testgit::/home/felipec/dev/git/t/trash
directory.t5801-remote-helpers/server did not send all necessary
objects

It's possible to send a ping command to the remote-helper, but doing
so triggers a SIGPIPE. I would rather show a proper error message as
my patch suggests by just checking if the command is running.

>>> Also, the design is such that the remote-helper stays alive, even
>>> after fast-export has finished.
>>
>> So if we expect to be able to communicate with the remote-helper after
>> fast-export has exited, is it a protocol failure that the helper does
>> not say "yes, I finished the export" or similar? If so, can we fix that?
>>
>> I am not too familiar with this protocol, but it looks like we read from
>> helper->out right after closing the exporter, to get the ref statuses.
>> Shouldn't we be detecting the error if the helper hangs up there?
>
> I guess that should be possible, I'll give that a try.

I gave this a try and it does work, but it seems rather convoluted to me:

diff --git a/transport-helper.c b/transport-helper.c
index f0d28aa..10b7842 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -25,7 +25,8 @@ struct helper_data {
 		option : 1,
 		push : 1,
 		connect : 1,
-		no_disconnect_req : 1;
+		no_disconnect_req : 1,
+		done_export : 1;
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -46,7 +47,7 @@ static void sendline(struct helper_data *helper,
struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }

-static int recvline_fh(FILE *helper, struct strbuf *buffer)
+static int recvline_fh(FILE *helper, struct strbuf *buffer, int safe)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -54,7 +55,10 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		if (safe)
+			return -1;
+		else
+			exit(128);
 	}

 	if (debug)
@@ -64,7 +68,12 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)

 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer);
+	return recvline_fh(helper->out, buffer, 0);
+}
+
+static int recvline_safe(struct helper_data *helper, struct strbuf *buffer)
+{
+	return recvline_fh(helper->out, buffer, 1);
 }

 static void xchgline(struct helper_data *helper, struct strbuf *buffer)
@@ -201,6 +210,8 @@ static struct child_process *get_helper(struct
transport *transport)
 			strbuf_addstr(&arg, "--import-marks=");
 			strbuf_addstr(&arg, capname + strlen("import-marks "));
 			data->import_marks = strbuf_detach(&arg, NULL);
+		} else if (!strcmp(capname, "done-export")) {
+			data->done_export = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.",
@@ -540,7 +551,7 @@ static int process_connect_service(struct
transport *transport,
 		goto exit;

 	sendline(data, &cmdbuf);
-	recvline_fh(input, &cmdbuf);
+	recvline_fh(input, &cmdbuf, 0);
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
@@ -704,19 +715,30 @@ static void push_update_ref_status(struct strbuf *buf,
 	(*ref)->remote_status = msg;
 }

-static void push_update_refs_status(struct helper_data *data,
+static int push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
+	int done = 0;
+
 	for (;;) {
-		recvline(data, &buf);
-		if (!buf.len)
+		if (recvline_safe(data, &buf) || !buf.len)
+			break;
+
+		if (!strncmp(buf.buf, "done", 4)) {
+			done = 1;
 			break;
+		}

 		push_update_ref_status(&buf, &ref, remote_refs);
 	}
 	strbuf_release(&buf);
+
+	if (!data->done_export)
+		return 0;
+
+	return !done;
 }

 static int push_refs_with_push(struct transport *transport,
@@ -776,8 +798,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);

-	push_update_refs_status(data, remote_refs);
-	return 0;
+	return push_update_refs_status(data, remote_refs);
 }

 static int push_refs_with_export(struct transport *transport,
@@ -829,8 +850,7 @@ static int push_refs_with_export(struct transport
*transport,
 	if (!check_command(data->helper))
 		die("Error while running helper");

-	push_update_refs_status(data, remote_refs);
-	return 0;
+	return push_update_refs_status(data, remote_refs);
 }

 static int push_refs(struct transport *transport,

-- 
Felipe Contreras
