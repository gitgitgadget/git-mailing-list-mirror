From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 13:40:19 +0000
Message-ID: <4D70EBC3.3010400@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060701040003050404000303"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 14:49:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvVNN-00030c-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 14:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab1CDNsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 08:48:55 -0500
Received: from brent.tribalogic.net ([78.86.109.144]:53775 "EHLO
	summit.brent.tribalogic.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752492Ab1CDNsy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 08:48:54 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Mar 2011 08:48:54 EST
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id CD21ED8706
	for <git@vger.kernel.org>; Fri,  4 Mar 2011 13:40:22 +0000 (GMT)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id yUnur02-7LWA for <git@vger.kernel.org>;
	Fri,  4 Mar 2011 13:40:19 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Mageia/3.1.8-1.mga1 (1) Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168439>

This is a multi-part message in MIME format.
--------------060701040003050404000303
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

We recently found a bug in git-am 1.7.4.1 while working on PulseAudio.

It seems that it mis-applied a patch and did so silently without
generating any warnings. It is reproducible and has been confirmed on
different distros.

I make reference to the bug here:
http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/8840/focus=8857

In order to reproduce:

git clone http://git.0pointer.de/repos/pulseaudio.git
git co -b misapply 0ce3017b7407ab1c4094f7ce271bb68319a7eba7
git am 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch

(I've attached the patch here for convenience).

As you can see, a call to the function check_required is incorrectly
located after application. It is now recursive and uncalled. It should
be called in element_probe() function as per the original patch.

This is quite a serious problem. In our case it turned out to compile
fine. So after reviewing the patch, I applied it and received no errors
and thus thought no more about it. If this kind of thing can sneak by
undetected, then it could introduce flaws quite easily :s



For reference, applying the patch manually with patch works fine and
does not result in an error:

$ cat 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch |
patch -p1
patching file src/modules/alsa/alsa-mixer.c
Hunk #1 succeeded at 1121 (offset 103 lines).
Hunk #2 succeeded at 1325 (offset 103 lines).
Hunk #3 succeeded at 1356 (offset 103 lines).
Hunk #4 succeeded at 1613 (offset 103 lines).
Hunk #5 succeeded at 1640 (offset 103 lines).
Hunk #6 succeeded at 1913 (offset 103 lines).
Hunk #7 succeeded at 1997 (offset 105 lines).
Hunk #8 succeeded at 2242 (offset 106 lines).
Hunk #9 succeeded at 2261 (offset 106 lines).
Hunk #10 succeeded at 2312 (offset 106 lines).
patching file src/modules/alsa/alsa-mixer.h
Hunk #1 succeeded at 112 (offset 1 line).
Hunk #2 succeeded at 133 (offset 1 line).
Hunk #3 succeeded at 169 (offset 1 line).
patching file src/modules/alsa/mixer/paths/analog-output.conf.common


All the best

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]


--------------060701040003050404000303
Content-Type: text/x-patch;
 name="0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-alsa-mixer-add-required-any-and-required-for-enum-op.pa";
 filename*1="tch"

>From ae83e51c82a747332494bf10c245281e49343fe3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Dec 2010 12:29:27 +0100
Subject: [PATCH 2/6] alsa-mixer: add required-any and required-* for enum options

Now you can add required-any to elements in a path and the path
will be valid as long as at least one of the elements are present.
Also you can have required, required-any and required-absent in
element options, causing a path to be unsupported if an option is
(not) present (simplified example: to skip line in path if
"Capture source" doesn't have a "Line In" option).

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/modules/alsa/alsa-mixer.c                      |   90 +++++++++++++++++---
 src/modules/alsa/alsa-mixer.h                      |    8 ++
 .../alsa/mixer/paths/analog-output.conf.common     |    5 +
 3 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/src/modules/alsa/alsa-mixer.c b/src/modules/alsa/alsa-mixer.c
index eb50ae2..2c47319 100644
--- a/src/modules/alsa/alsa-mixer.c
+++ b/src/modules/alsa/alsa-mixer.c
@@ -1018,6 +1018,38 @@ static int check_required(pa_alsa_element *e, snd_mixer_elem_t *me) {
     if (e->required_absent == PA_ALSA_REQUIRED_ANY && (has_switch || has_volume || has_enumeration))
         return -1;
 
+    if (e->required_any != PA_ALSA_REQUIRED_IGNORE) {
+        switch (e->required_any) {
+        case PA_ALSA_REQUIRED_VOLUME:
+            e->path->req_any_present |= (e->volume_use != PA_ALSA_VOLUME_IGNORE);
+            break;
+        case PA_ALSA_REQUIRED_SWITCH:
+            e->path->req_any_present |= (e->switch_use != PA_ALSA_SWITCH_IGNORE);
+            break;
+        case PA_ALSA_REQUIRED_ENUMERATION:
+            e->path->req_any_present |= (e->enumeration_use != PA_ALSA_ENUMERATION_IGNORE);
+            break;
+        case PA_ALSA_REQUIRED_ANY:
+            e->path->req_any_present |=
+                (e->volume_use != PA_ALSA_VOLUME_IGNORE) ||
+                (e->switch_use != PA_ALSA_SWITCH_IGNORE) ||
+                (e->enumeration_use != PA_ALSA_ENUMERATION_IGNORE);
+            break;
+        }
+    }
+
+    if (e->enumeration_use == PA_ALSA_ENUMERATION_SELECT) {
+        pa_alsa_option *o;
+        PA_LLIST_FOREACH(o, e->options) {
+            e->path->req_any_present |= (o->required_any != PA_ALSA_REQUIRED_IGNORE) &&
+                (o->alsa_idx >= 0);
+            if (o->required != PA_ALSA_REQUIRED_IGNORE && o->alsa_idx < 0)
+                return -1;
+            if (o->required_absent != PA_ALSA_REQUIRED_IGNORE && o->alsa_idx >= 0)
+                return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -1190,9 +1222,6 @@ static int element_probe(pa_alsa_element *e, snd_mixer_t *m) {
 
     }
 
-    if (check_required(e, me) < 0)
-        return -1;
-
     if (e->switch_use == PA_ALSA_SWITCH_SELECT) {
         pa_alsa_option *o;
 
@@ -1224,6 +1253,9 @@ static int element_probe(pa_alsa_element *e, snd_mixer_t *m) {
         }
     }
 
+    if (check_required(e, me) < 0)
+        return -1;
+
     return 0;
 }
 
@@ -1478,20 +1510,23 @@ static int element_parse_required(
 
     pa_alsa_path *p = userdata;
     pa_alsa_element *e;
+    pa_alsa_option *o;
     pa_alsa_required_t req;
 
     pa_assert(p);
 
-    if (!(e = element_get(p, section, TRUE))) {
+    e = element_get(p, section, TRUE);
+    o = option_get(p, section);
+    if (!e && !o) {
         pa_log("[%s:%u] Required makes no sense in '%s'", filename, line, section);
         return -1;
     }
 
     if (pa_streq(rvalue, "ignore"))
         req = PA_ALSA_REQUIRED_IGNORE;
-    else if (pa_streq(rvalue, "switch"))
+    else if (pa_streq(rvalue, "switch") && e)
         req = PA_ALSA_REQUIRED_SWITCH;
-    else if (pa_streq(rvalue, "volume"))
+    else if (pa_streq(rvalue, "volume") && e)
         req = PA_ALSA_REQUIRED_VOLUME;
     else if (pa_streq(rvalue, "enumeration"))
         req = PA_ALSA_REQUIRED_ENUMERATION;
@@ -1502,10 +1537,28 @@ static int element_parse_required(
         return -1;
     }
 
-    if (pa_streq(lvalue, "required-absent"))
-        e->required_absent = req;
-    else
-        e->required = req;
+    if (pa_streq(lvalue, "required-absent")) {
+        if (e)
+            e->required_absent = req;
+        if (o)
+            o->required_absent = req;
+    }
+    else if (pa_streq(lvalue, "required-any")) {
+        if (e) {
+            e->required_any = req;
+            e->path->has_req_any = TRUE;
+        }
+        if (o) {
+            o->required_any = req;
+            o->element->path->has_req_any = TRUE;
+        }
+    }
+    else {
+        if (e)
+            e->required = req;
+        if (o)
+            o->required = req;
+    }
 
     return 0;
 }
@@ -1757,7 +1810,10 @@ static int element_verify(pa_alsa_element *e) {
 
     pa_assert(e);
 
+//    pa_log_debug("Element %s, path %s: r=%d, r-any=%d, r-abs=%d", e->alsa_name, e->path->name, e->required, e->required_any, e->required_absent);
     if ((e->required != PA_ALSA_REQUIRED_IGNORE && e->required == e->required_absent) ||
+        (e->required_any != PA_ALSA_REQUIRED_IGNORE && e->required_any == e->required_absent) ||
+        (e->required_absent == PA_ALSA_REQUIRED_ANY && e->required_any != PA_ALSA_REQUIRED_IGNORE) ||
         (e->required_absent == PA_ALSA_REQUIRED_ANY && e->required != PA_ALSA_REQUIRED_IGNORE)) {
         pa_log("Element %s cannot be required and absent at the same time.", e->alsa_name);
         return -1;
@@ -1836,6 +1892,7 @@ pa_alsa_path* pa_alsa_path_new(const char *fname, pa_alsa_direction_t direction)
         { "override-map.2",      element_parse_override_map,        NULL, NULL },
         /* ... later on we might add override-map.3 and so on here ... */
         { "required",            element_parse_required,            NULL, NULL },
+        { "required-any",        element_parse_required,            NULL, NULL },
         { "required-absent",     element_parse_required,            NULL, NULL },
         { "direction",           element_parse_direction,           NULL, NULL },
         { "direction-try-other", element_parse_direction_try_other, NULL, NULL },
@@ -2079,11 +2136,13 @@ int pa_alsa_path_probe(pa_alsa_path *p, snd_mixer_t *m, pa_bool_t ignore_dB) {
                                 min_dB[t] += e->min_dB;
                                 max_dB[t] += e->max_dB;
                             }
-                    } else
+                    } else {
                         /* Hmm, there's another element before us
                          * which cannot do dB volumes, so we we need
                          * to 'neutralize' this slider */
                         e->volume_use = PA_ALSA_VOLUME_ZERO;
+                        pa_log_info("Zeroing volume of '%s' on path '%s'", e->alsa_name, p->name);
+                    }
                 }
             } else if (p->has_volume)
                 /* We can't use this volume, so let's ignore it */
@@ -2096,6 +2155,12 @@ int pa_alsa_path_probe(pa_alsa_path *p, snd_mixer_t *m, pa_bool_t ignore_dB) {
             p->has_mute = TRUE;
     }
 
+    if (p->has_req_any && !p->req_any_present) {
+        p->supported = FALSE;
+        pa_log_debug("Skipping path '%s', none of required-any elements preset.", p->name);
+        return -1;
+    }
+
     path_drop_unsupported(p);
     path_make_options_unique(p);
     path_create_settings(p);
@@ -2141,13 +2206,14 @@ void pa_alsa_element_dump(pa_alsa_element *e) {
     pa_alsa_option *o;
     pa_assert(e);
 
-    pa_log_debug("Element %s, direction=%i, switch=%i, volume=%i, enumeration=%i, required=%i, required_absent=%i, mask=0x%llx, n_channels=%u, override_map=%s",
+    pa_log_debug("Element %s, direction=%i, switch=%i, volume=%i, enumeration=%i, required=%i, required_any=%i, required_absent=%i, mask=0x%llx, n_channels=%u, override_map=%s",
                  e->alsa_name,
                  e->direction,
                  e->switch_use,
                  e->volume_use,
                  e->enumeration_use,
                  e->required,
+                 e->required_any,
                  e->required_absent,
                  (long long unsigned) e->merged_mask,
                  e->n_channels,
diff --git a/src/modules/alsa/alsa-mixer.h b/src/modules/alsa/alsa-mixer.h
index a0d4fcb..a6499b6 100644
--- a/src/modules/alsa/alsa-mixer.h
+++ b/src/modules/alsa/alsa-mixer.h
@@ -111,6 +111,10 @@ struct pa_alsa_option {
     char *name;
     char *description;
     unsigned priority;
+
+    pa_alsa_required_t required;
+    pa_alsa_required_t required_any;
+    pa_alsa_required_t required_absent;
 };
 
 /* And element wraps one specific ALSA element. A series of elements *
@@ -128,6 +132,7 @@ struct pa_alsa_element {
     pa_alsa_enumeration_use_t enumeration_use;
 
     pa_alsa_required_t required;
+    pa_alsa_required_t required_any;
     pa_alsa_required_t required_absent;
 
     pa_bool_t override_map:1;
@@ -163,6 +168,9 @@ struct pa_alsa_path {
     pa_bool_t has_mute:1;
     pa_bool_t has_volume:1;
     pa_bool_t has_dB:1;
+    /* These two are used during probing only */
+    pa_bool_t has_req_any:1;
+    pa_bool_t req_any_present:1;
 
     long min_volume, max_volume;
     double min_dB, max_dB;
diff --git a/src/modules/alsa/mixer/paths/analog-output.conf.common b/src/modules/alsa/mixer/paths/analog-output.conf.common
index 6131da5..ffd1b41 100644
--- a/src/modules/alsa/mixer/paths/analog-output.conf.common
+++ b/src/modules/alsa/mixer/paths/analog-output.conf.common
@@ -63,10 +63,15 @@
 ;                                        # by the option name, resp. on/off if the element is a switch.
 ; name = ...                             # Logical name to use in the path identifier
 ; priority = ...                         # Priority if this is made into a device port
+; required = ignore | enumeration | any            # In this element, this option must exist or the path will be invalid. ("any" is an alias for "enumeration".)
+; required-any = ignore | enumeration | any        # In this element, either this or another option must exist (or an element)
+; required-absent = ignore | enumeration | any     # In this element, this option must not exist or the path will be invalid
 ;
 ; [Element ...]                          # For each element that we shall control
 ; required = ignore | switch | volume | enumeration | any     # If set, require this element to be of this kind and available,
 ;                                                             # otherwise don't consider this path valid for the card
+; required-any = ignore | switch | volume | enumeration | any # If set, at least one of the elements with required-any in this
+;                                                             # path must be present, otherwise this path is invalid for the card
 ; required-absent = ignore | switch | volume                  # If set, require this element to not be of this kind and not
 ;                                                             # available, otherwise don't consider this path valid for the card
 ;
-- 
1.7.1



--------------060701040003050404000303--
