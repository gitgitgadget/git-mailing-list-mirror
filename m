From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] upload-pack: allow shallow fetching from a read-only
 repository
Date: Wed, 5 Mar 2014 19:43:04 +0700
Message-ID: <20140305124304.GA27214@lanh>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <1393936205-15953-1-git-send-email-pclouds@gmail.com>
 <xmqqr46hltrl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 13:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLB9m-00036l-SA
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 13:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbaCEMmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 07:42:38 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52578 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbaCEMmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 07:42:37 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so1020626pbb.36
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BnoygjDUxCRdYuE/mZYq9cMEkOjV0EP5ut2wEKgxSK0=;
        b=ZfdRqaqp57FDfqUxV8x4HnaDax8UmmGjiD8Rfz3GwwBtvCZp3j3OF/B/OHdxKPHlaw
         ZiFy302l+ORp6pBlCWXlk4bjjjlcNNpb4xUcxkz+VWUiVn7sdF3H+vlD6+OFgGxSuXOq
         2yvq7cRvx5fM9V2veKREQc/XZV0P7oRbG/Zjw8/Kz9u7RvEgFLH2PmzVQiFjpjMy5cCN
         MN4Ke+lJgC5bnq31qTDsH9+SBt3L7cIBK5bR4ftu5NPGCBokVnNQpCVLfsxUmcQThnYk
         DYwZSwmdjnvsC4d+niGu1lTQph1OiKw1bnZWjIPONV5SdCKxuOOwEGX9YIegr+aM7y0j
         dv1w==
X-Received: by 10.66.66.66 with SMTP id d2mr6722345pat.80.1394023356284;
        Wed, 05 Mar 2014 04:42:36 -0800 (PST)
Received: from lanh ([115.73.234.234])
        by mx.google.com with ESMTPSA id oz7sm7957749pbc.41.2014.03.05.04.42.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Mar 2014 04:42:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 05 Mar 2014 19:43:04 +0700
Content-Disposition: inline
In-Reply-To: <xmqqr46hltrl.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243435>

On Wed, Mar 5, 2014 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I notice that the original code, with or without this change, allows
> upload-pack spawned by daemon to attempt to write into GIT_DIR.
> As upload-pack is supposed to be a read-only operation, this is
> quite bad.
>
> Perhaps we should give server operators an option to run their
> daemon -> upload-pack chain to always write to a throw-away
> directory of their choice, without ever attempting to write to
> GIT_DIR it serves?

That would be setting TMPDIR before running git-daemon, I think.
Except places that we ignore TMPDIR like this one.

> How well is the access to the temporary shallow file controlled in
> your code (sorry, but I do not recall carefully reading your patch
> that added the mechanism with security issues in mind, so now I am
> asking)?  When it is redirected to TMPDIR (let's forget GIT_DIR for
> now---if an attacker can write into there, the repository is already
> lost), can an attacker race with us to cause us to overwrite we do
> not expect to?

I'm sorry to say that attackers were simply not a concern when I wrote
the patch. Not even that upload-pack is a read-only operation (so
obvious now that I think about this). I think racing is possible, yes.

> Even if it turns out that this patch is secure enough as-is, we
> definitely need to make sure that server operators, who want to keep
> their upload-pack truly a read-only operation, know that it is
> necessary to (1) keep the system user they run git-daemon under
> incapable of writing into GIT_DIR, and (2) make sure TMPDIR points
> at somewhere only git-daemon user and nobody else can write into,
> somewhere in the documentation.

If only there is a way to pass this info without a temporary
file. Multiplexing it to pack-objects' stdin should work. It may be
ugly, but it's probably the safest way.

Wait it does not look that ugly. We can feed "--shallow <SHA1>" lines
before sending want/have/edge objects. Something like this seems to
work (just ran a few shallow-related tests, not the whole test suite)

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..130097c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2467,6 +2467,14 @@ static void get_object_list(int ac, const char **av)
 				write_bitmap_index = 0;
 				continue;
 			}
+			if (starts_with(line, "--shallow ")) {
+				unsigned char sha1[20];
+				if (get_sha1_hex(line + 10, sha1))
+					die("not an SHA-1 '%s'", line + 10);
+				register_shallow(sha1);
+				/* XXX: set shallow.c:is_shallow = 1 ? */
+				continue;
+			}
 			die("not a rev '%s'", line);
 		}
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..a5c50e4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -70,6 +70,14 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 	return sz;
 }
 
+static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
+{
+	FILE *fp = cb_data;
+	if (graft->nr_parent == -1)
+		fprintf(fp, "--shallow %s\n", sha1_to_hex(graft->sha1));
+	return 0;
+}
+
 static void create_pack_file(void)
 {
 	struct child_process pack_objects;
@@ -81,12 +89,10 @@ static void create_pack_file(void)
 	const char *argv[12];
 	int i, arg = 0;
 	FILE *pipe_fd;
-	char *shallow_file = NULL;
 
 	if (shallow_nr) {
-		shallow_file = setup_temporary_shallow(NULL);
 		argv[arg++] = "--shallow-file";
-		argv[arg++] = shallow_file;
+		argv[arg++] = "";
 	}
 	argv[arg++] = "pack-objects";
 	argv[arg++] = "--revs";
@@ -114,6 +120,9 @@ static void create_pack_file(void)
 
 	pipe_fd = xfdopen(pack_objects.in, "w");
 
+	if (shallow_nr)
+		for_each_commit_graft(write_one_shallow, pipe_fd);
+
 	for (i = 0; i < want_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
 			sha1_to_hex(want_obj.objects[i].item->sha1));
@@ -242,12 +251,6 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_file) {
-		if (*shallow_file)
-			unlink(shallow_file);
-		free(shallow_file);
-	}
-
 	/* flush the data */
 	if (0 <= buffered) {
 		data[0] = buffered;
-- 8< --
-- 
Duy
