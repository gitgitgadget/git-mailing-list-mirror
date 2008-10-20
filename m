From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix multiple issues in index-pack
Date: Mon, 20 Oct 2008 16:46:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:00:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks1fA-0003Yq-5p
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbYJTUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYJTUq0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:46:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39094 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYJTUq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:46:26 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9200E8S1P7JUBO@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 16:46:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98738>

Since commit 9441b61dc5, two issues affected correct behavior of 
index-pack:

 1) The real_type of a delta object is the 'real_type' of its base, not
    the 'type' which can be a "delta type".  Consequence of this is a
    corrupted pack index file which only needs to be recreated with a 
    good index-pack command ('git verify-pack' will flag those).

 2( The code sequence:

        result->data = patch_delta(get_base_data(base), base->obj->size,
                                   delta_data, delta_size, &result->size);

    has two issues of its own since base->obj->size should instead be
    base->size as we want the size of the actual object data and not
    the size of the delta object it is represented by.  Except that 
    simply replacing base->obj->size with base->size won't make the
    code more correct as the C language doesn't enforce a particular 
    ordering for the evaluation of needed arguments for a function call,
    hence base->size could be pushed on the stack before get_base_data()
    which initializes base->size is called.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Damn... this one was subtle.  And I'm still wondering how the hell the 
test suite is able to pass with this.  I'll try to figure out why and 
come up with better tests.

diff --git a/index-pack.c b/index-pack.c
index 0a917d7..e179bd9 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -514,15 +514,14 @@ static void *get_base_data(struct base_data *c)
 static void resolve_delta(struct object_entry *delta_obj,
 			  struct base_data *base, struct base_data *result)
 {
-	void *delta_data;
-	unsigned long delta_size;
+	void *base_data, *delta_data;
 
-	delta_obj->real_type = base->obj->type;
+	delta_obj->real_type = base->obj->real_type;
 	delta_data = get_data_from_pack(delta_obj);
-	delta_size = delta_obj->size;
+	base_data = get_base_data(base);
 	result->obj = delta_obj;
-	result->data = patch_delta(get_base_data(base), base->obj->size,
-				   delta_data, delta_size, &result->size);
+	result->data = patch_delta(base_data, base->size,
+				   delta_data, delta_obj->size, &result->size);
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
